# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'credit-card-sms-parser'
  spec.version       = '0.3.3'
  spec.authors       = %w(Hanson Benjamin)
  spec.email         = %w(jehokim@live.com)
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  end

  spec.summary       = 'Parsing credit card SMS messages'
  spec.description   = 'It parses out the SMS notifications for each credit (or debit) transaction, allowing you to collect the following information: transaction amount, name of credit card company, payee (store), total amount. For the time being, support is limited to Korean credit card companies only.'
  spec.homepage      = 'https://github.com/kakao/credit-card-sms-parser'
  spec.licenses      = %w(MIT)

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rltk', '>= 3.0.0'
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
end
