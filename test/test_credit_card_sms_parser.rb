require 'minitest/autorun'
require 'credit_card_sms_parser'
require 'active_support/core_ext/enumerable'

class TestCreditCardSmsParser < Minitest::Test
  include CreditCardSmsParser
  def setup
    # @hyundae_card = CreditCardSmsParser::HyundaeCard.new
    # @hana_card = CreditCardSmsParser::HanaCard.new
  end

  def test_hyundae_card
    s = <<-eos
[Web발신]
[현대카드]-승인
김재*님
1,500원(일시불)
마노핀익스프레스신림
누적:354,220원
    eos
    assert_equal('마노핀익스프레스신림', parse_sms(s)[:shop_name])
  end

  def test_hana_card
    s = <<-eos
[Web발신]
하나(6*8*)김*호님 04/06 15:26 씨유판교 일시불/3,500원/누적-4,645원
    eos
    assert_equal('씨유판교', parse_sms(s)[:shop_name])
  end

  def test_kb_card
    s = <<-eos
[Web발신]
KB국민카드 2*5*
정*욱님
03/25 09:30
2,200원
미니스톱판교점
누적 97,440원
    eos
    assert_equal('미니스톱판교점', parse_sms(s)[:shop_name])

    s = <<-eos
[Web발신]
[KB]04/08 21:27
078501**554
주식회사개성
체크카드출금
13,000
    eos
    assert_equal('개성', parse_sms(s)[:shop_name])
  end

  def test_samsung_card
    s = <<-eos
[Web발신]
삼성가족카드승인9785
03/24 18:45
10,000원
일시불
소문난우동
    eos
    assert_equal('소문난우동', parse_sms(s)[:shop_name])
  end

  def test_keb_hana_card
    s = <<-eos
[Web발신]
KEB하나 박솔*님 4*6*
일시불 30,000원
(주)이니 03/23 09:58
누적 2,368,397원
    eos
    assert_equal('이니', parse_sms(s)[:shop_name])
  end

  def test_city_bc_card
    s = <<-eos
[체크.승인]
22,000원
씨티BC(1*9*)김*정님
01/23 12:34
매일식당
    eos
    assert_equal('매일식당', parse_sms(s)[:shop_name])
  end

  def test_상호명에_띄어쓰기_포함
    s = <<-eos
[Web발신]
농협BC(4*8*)오*름님.
04/14 11:51.
일시불81,400원.
누적금액679,780원.
버거킹 판교유스페
    eos
    assert_equal('버거킹 판교유스페', parse_sms(s)[:shop_name])
  end

  def test_상호명에_영어_포함
    s = <<-eos
[Web발신]
[현대카드]-승인
***님
3,400원(일시불)
SK플래닛판교마트
누적:612,900원
    eos
    assert_equal('SK플래닛판교마트', parse_sms(s)[:shop_name])
  end

  def test_뒤에_사용_이라는_단어가_포함
    s = <<-eos
[Web발신]
KB국민체크(6*3*)
***님
04/24 12:13
20,000원
효소원판교점 사용
    eos
    assert_equal('효소원판교점', parse_sms(s)[:shop_name])
  end

  def test_잔액이_홀로_빠져나와_있는_메시지
    s = <<-eos
[Web발신]
김*호님
삼성법인6265
04/22 19:56
찌개애감동
16,000원
일시불
잔액
4,968,160원
    eos
    assert_equal('찌개애감동', parse_sms(s)[:shop_name])
  end

  def test_keb_hana_card2
    s = <<-eos
[Web발신]
KEB하나  박우*님 7*5* 일시불     10,000원 롯데쇼핑( 04/18 18:49
    eos
    assert_equal('롯데쇼핑', parse_sms(s)[:shop_name])
  end

  def test_shinhan_card
    s = <<-eos
[Web발신]
신한카드승인 강*혜(9*0*) 04/27 21:31 (일시불)39,500원 (주)페어몬트 누적688,800원
    eos
    assert_equal('페어몬트', parse_sms(s)[:shop_name])
  end

  def test_kb
    s = <<-eos
[Web발신]
KB국민체크(17)
강*혜님
04/30 22:34
87,000원
이꾸　정자점 사용
    eos
    assert_equal('이꾸 정자점', parse_sms(s)[:shop_name])
  end

  def test_숫자_포함
    s = <<-eos
[Web발신]
[KB]05/08 21:44
078501**554
365PLUS정자
체크카드출금
2,400
eos
    assert_equal('365PLUS정자', parse_sms(s)[:shop_name])
  end

  def test_aa
    s = <<-eos
[Web발신]
[KB]05/17 12:33
435002**739
대성할인마트
체크카드출금
4,350
잔액3,172,018
    eos
    assert_equal('대성할인마트', parse_sms(s)[:shop_name])
  end

  def test_취소_내역
    s = <<-eos
[Web발신]
KB*카드
김재호님
05/29 20:52
320,000원
우리동물메디컬 취소
누적 560,060원
    eos
    assert_equal('우리동물메디컬', parse_sms(s)[:shop_name])
  end
end
