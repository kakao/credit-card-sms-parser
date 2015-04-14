# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'credit-card-sms-parser'
  gem.version       = '0.0.6'
  gem.licenses      = %w(MIT)
  gem.authors       = %w(Hanson Benjamin)
  gem.email         = %w(jehokim@live.com)
  gem.description   = 'It parses out the SMS notifications for each credit (or debit) transaction, allowing you to collect the following information: transaction amount, name of credit card company, payee (store), total amount. For the time being, support is limited to Korean credit card companies only.'
  gem.summary       = 'Parsing credit card SMS messages'
  gem.homepage      = 'https://github.com/kakao/credit-card-sms-parser'
  gem.metadata['allowed_push_host'] = 'https://rubygems.org'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'rltk'
end
