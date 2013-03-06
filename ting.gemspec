$:.unshift './lib'

require 'ting'

Gem::Specification.new do |spec|
  spec.name = "ting"
  spec.authors = ["Arne Brasseur"]
  spec.email = ["arne.brasseur@gmail.com"]
  spec.homepage = %q{http://github.com/arnebrasseur/ting}

  spec.version = Ting::VERSION
  spec.date = %q{2012-05-06}
  spec.platform = Gem::Platform::RUBY

  spec.description = %q{Ting can convert between various phonetic representations of Mandarin Chinese. It can also handle various representation of tones, so it can be used to convert pinyin with numbers to pinyin with tones.}
  spec.summary = %q{A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles.}

  spec.files = ["History.txt", "README.md", "Rakefile", "TODO"] + Dir["{lib,examples,test}/**/*.{rb,rhtml,csv,txt,yaml}"]
  spec.require_paths = ["lib"]
  spec.test_files = ["test/test_hanyu_coverage.rb", "test/test_comparison.rb"]

  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README.md", "History.txt", "TODO"]
  spec.rdoc_options = ["--main", "README.md"]

  spec.rubygems_version = %q{1.2.0}
  spec.specification_version = 2 if spec.respond_to? :specification_version=

  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rake')
end
