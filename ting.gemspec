
require File.expand_path('../lib/ting/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name     = 'ting'
  gem.version  = Ting::VERSION
  gem.authors  = [ 'Arne Brasseur' ]
  gem.email    = [ 'arne@arnebrasseur.net' ]
  gem.homepage = 'http://github.com/github/ting'

  gem.platform = Gem::Platform::RUBY

  gem.description = %q{Ting can convert between various phonetic representations of Mandarin Chinese. It can also handle various representation of tones, so it can be used to convert pinyin with numbers to pinyin with tones.}
  gem.summary = %q{A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles.}

  gem.require_paths    = %w[ lib ]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec test`.split($/)
  gem.extra_rdoc_files = %w[ README.md History.txt TODO ]

  gem.add_development_dependency 'rake', '~> 10.1'
  gem.add_development_dependency 'rspec', '~> 2.14'
end
