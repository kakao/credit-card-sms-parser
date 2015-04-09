# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'credit-card-sms-parser'
  gem.version       = '0.0.4'
  gem.licenses      = %w(MIT)
  gem.authors       = %w(Benjamin)
  gem.email         = %w(benjamin.k@daumkakao.com)
  gem.description   = %q{credit-card-sms-parser}
  gem.summary       = %q{It parses credit card sms.}
  gem.homepage      = 'https://github.com/BenjaminKim/credit-card-sms-parser'
  gem.metadata['allowed_push_host'] = 'http://gems.iwilab.com:2000/'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'rltk'
end
