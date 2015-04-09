require 'minitest/autorun'
require 'credit_card_sms_parser'
require 'active_support/core_ext/enumerable'

class TestCreditCardSmsParser < Minitest::Test
  include CreditCardSmsParser
  def setup
    # @hyundae_card = CreditCardSmsParser::HyundaeCard.new
    # @hana_card = CreditCardSmsParser::HanaCard.new
  end

  def test_parse
    s = <<-eos
[Web발신]
[현대카드]-승인
김재*님
1,500원(일시불)
마노핀익스프레스신림
누적:354,220원
    eos
    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"


    s = <<-eos
[Web발신]
하나(6*8*)김*호님 04/06 15:26 씨유판교 일시불/3,500원/누적-4,645원
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"

    s = <<-eos
[Web발신]
KB국민카드 2*5*
정*욱님
03/25 09:30
2,200원
미니스톱판교점
누적 97,440원
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"

    s = <<-eos
[Web발신]
삼성가족카드승인9785
03/24 18:45
10,000원
일시불
소문난우동
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"

    s = <<-eos
[Web발신]
"KEB하나 박솔*님 4*6*
일시불 30,000원
(주)이니 03/23 09:58
누적 2,368,397원"
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"

    s = <<-eos
[체크.승인]
22,000원
씨티BC(1*9*)김*정님
01/23 12:34
매일식당
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"

    s = <<-eos
[Web발신]
[KB]04/08 21:27
078501**554
주식회사개성
체크카드출금
13,000
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"

    s = <<-eos
[Web발신]
하나(6*8*)김*호님 04/02 19:59 (주)보나 일시불/4,500원/누적-134,049원
eos

    puts "SHOP: #{parse_sms('111', s)[:SHOP]}"
  end
end
