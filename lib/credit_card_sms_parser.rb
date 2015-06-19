require 'active_support/core_ext/object'
require 'rltk/lexer'

class String
  def to_num
    if self[0] == '-'
      (self[0] + self[1..-1].gsub(/\D/, '')).to_i
    else
      self.gsub(/\D/, '').to_i
    end
  end
end

class KoreanCreditCardLexer < RLTK::Lexer
  rule(/\[Web발신\]/) { |t| [:header, t]}
  rule(/\(Web발신\)/) { |t| [:header, t]}
  rule(/체크카드출금/) { |t| [:header, t]}
  rule(/[\p{Hangul}\*]{2,4}님/) { |t| [:user_name, t]}
  rule(/누적[\s:\-]?[\d,\-]+원/) { |t| [:money_total, t.to_num] }
  rule(/누적-[\d,\-]+원/) { |t| [:money_total, t.to_num] }
  rule(/잔액[\d,\-]+원?/) { |t| [:remain_total, t.to_num] }
  rule(/[\d,\-]+원?/) { |t| [:money, t.to_num] }
  rule(/\(주\)\p{Hangul}+/) {|t| [:shop_name, t[3..-1]]}
  rule(/\p{Hangul}+\([\d\*]{4}\)/) {|t| [:card, t]}
  rule(/\S+은행/) {|t| [:bank, t]}
  rule(/KEB하나/) {|t| [:bank, t]}
  rule(/\S+카드/) {|t| [:card, t]}
  rule(/\d\d\/\d\d/) {|t| [:date, t]}
  rule(/\d\d:\d\d/) {|t| [:time, t]}
  rule(/일시불/) { :type }
  rule(/^잔액/) { :type }
  rule(/주식회사\p{Hangul}+/) {|t| [:shop_name, t[4..-1]]}
  rule(/^\p{Hangul}+( +\p{Hangul}+)*?$/) { |t|
    t.chomp!(' 사용')
    t.chomp!(' 일시불')
    t.chomp!(' 취소')
    [:shop_name, t.strip]
  }
  rule(/[0-9A-Za-z\p{Hangul}]+/) {|t| [:shop_name, t.strip]}
  rule(/[\p{L}]+/) {|t| [:word, t]}
  rule(/[\p{P}]+/) {|t| [:punctuation, t]}
  rule(/[\d\*]+/) { :number }
  rule(/\s/) {|t| [:space, t]}
end

require 'awesome_print'
module CreditCardSmsParser
  CARD_MAP = {
    '15776200' => '현대카드',
    '18001111' => '하나카드',
    '16449999' => '국민카드',
    '15881788' => '국민체크카드',
    '15884000' => '농협BC카드',
    '15661000' => '씨티카드',
  }

  def parse_sms(sms_message, phone_number = nil)
    tokens = KoreanCreditCardLexer.lex(sms_message)
    h = tokens.inject({}) do |memo, t|
      memo[t.type] = t.value
      memo
    end

    if phone_number
      h.merge(card_company_name: CARD_MAP[phone_number])
    end

    h.reject {|key, _|
      key == :header || key == :type || key == :punctuation || key == :space || key == :EOS
    }
  end
end