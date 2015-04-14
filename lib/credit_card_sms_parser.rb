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
  rule(/\[Web발신\]/) { |t| [:HEADER, t]}
  rule(/\(Web발신\)/) { |t| [:HEADER, t]}
  rule(/체크카드출금/) { |t| [:HEADER, t]}
  rule(/[\p{Hangul}\*]{2,4}님/) { |t| [:USER_NAME, t]}
  rule(/누적[\s:\-]?[\d,\-]+원/) { |t| [:MONEY_TOTAL, t.to_num] }
  rule(/누적-[\d,\-]+원/) { |t| [:MONEY_TOTAL, t.to_num] }
  rule(/[\d,\-]+원/) { |t| [:MONEY, t.to_num] }
  rule(/\(주\)\p{Hangul}+/) {|t| [:SHOP, t[3..-1]]}
  rule(/\p{Hangul}+\([\d\*]{4}\)/) {|t| [:CARD, t]}
  rule(/\S+은행/) {|t| [:BANK, t]}
  rule(/\S+카드/) {|t| [:CARD, t]}
  rule(/\d\d\/\d\d/) {|t| [:DATE, t]}
  rule(/\d\d:\d\d/) {|t| [:TIME, t]}
  rule(/일시불/) { :TYPE }
  rule(/주식회사\p{Hangul}+/) {|t| [:SHOP, t[4..-1]]}
  rule(/\p{Hangul}+/) {|t| [:SHOP, t.strip]}
  rule(/\//) {|t| [:SLASH, t]}
  rule(/[\p{L}\p{P}]+/) {|t| [:WORD, t]}
  rule(/[\d\*]+/) { :NUMBER }
  rule(/\s/) {|t| [:SPACE, t]}
end

module CreditCardSmsParser
  CARD_MAP = {
    '15776200' => '현대카드',
    '18001111' => '하나카드',
    '16449999' => '국민카드',
    '15884000' => '농협BC카드',
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

    h
  end
end