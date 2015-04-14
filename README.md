# credit-card-sms-parser
신용카드 회사에서 보내주는 sms 문자열을 읽어서 `가게명`, `사용금액`, `누적사용금액` 정보들을 추출해줍니다.

## 사용방법
```
gem install credit-card-sms-parser
$ pry
[1] pry(main)> require 'credit_card_sms_parser'
=> true
[2] pry(main)> include CreditCardSmsParser
=> Object
[3] pry(main)> parse_sms('18001111', '하나(6*8*)***님 04/06 15:26 씨유판교 일시불/3,500원/누적-4,645
=> {:CARD=>"하나(6*8*)",
 :DATE=>"04/06",
 :TIME=>"15:26",
 :SHOP=>"씨유판교",
 :MONEY=>4645,
 :card_name=>"하나카드"}
```

## 현재까지 지원하는(걸로 추정되는) 카드사
* 현대카드
* 하나SK카드
* 국민카드
