# credit-card-sms-parser
[![Gem Version](https://badge.fury.io/rb/credit-card-sms-parser.svg)](http://badge.fury.io/rb/credit-card-sms-parser)

신용카드 회사에서 보내주는 sms 문자열을 읽어서 `상호명`, `사용금액`, `누적사용금액` 정보들을 추출해줍니다.

## 사용방법
```
$ gem install credit-card-sms-parser
$ pry
[1] pry(main)> require 'credit_card_sms_parser'
=> true
[2] pry(main)> include CreditCardSmsParser
=> Object
[3] pry(main)> parse_sms('하나(6*8*)***님 04/06 15:26 씨유판교 일시불/3,500원/누적-4,645원')
=> {:CARD=>"하나(6*8*)",
 :DATE=>"04/06",
 :TIME=>"15:26",
 :SHOP=>"씨유판교",
 :MONEY=>4645}
```

## 현재까지 지원하는(걸로 추정되는) 카드사
* 현대카드
* 하나SK카드
* KEB 하나카드
* 국민카드
* 국민체크카드
* 농협
* 삼성법인카드

## 프로젝트에 기여하기
파싱이 제대로 되지 않는 SMS 문자열을 Issue 에 올려주시거나 test 코드에 추가해주시면 반영해드립니다.
물론 lexer 에 들어있는 Rule 을 직접 고쳐서 수정해주시는 것도 환영합니다.
바로 위 항목의 `지원하는 걸로 추정하는 카드사`에 대한 정보도 새로운 것이나 변경할 사항이 있으시면 바로잡아주시길 부탁드립니다. 
