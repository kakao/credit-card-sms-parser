# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'credit-card-sms-parser'
  gem.version       = '0.0.5'
  gem.licenses      = %w(MIT)
  gem.authors       = %w(Hanson Benjamin)
  gem.email         = %w(jehokim@live.com)
  gem.description   = %q{credit-card-sms-parser}
  gem.summary       = %q{It parses all Korean credit card messages.}
  gem.homepage      = 'https://github.com/kakao/credit-card-sms-parser'
  gem.metadata['allowed_push_host'] = 'https://rubygems.org'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'rltk'
end
