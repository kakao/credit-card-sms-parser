# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'credit-card-sms-parser'
  gem.version       = '0.0.1'
  gem.licenses      = %w(MIT)
  gem.authors       = %w(Benjamin)
  gem.email         = %w(benjamin.k@daumkakao.com)
  gem.description   = %q{Parse sms}
  gem.summary       = %q{It parses sms}
  gem.homepage      = 'https://github.daumkakao.com/kakao-dev/acts_as_json'
  gem.metadata['allowed_push_host'] = 'http://gems.iwilab.com:2000/'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
