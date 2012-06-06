$:.unshift './lib'

require 'ting'

Gem::Specification.new do |s|
  s.name = "ting"
  s.authors = ["Arne Brasseur"]
  s.email = ["arne.brasseur@gmail.com"]
  s.homepage = %q{http://github.com/arnebrasseur/ting}

  s.version = Ting::VERSION
  s.date = %q{2012-05-06}
  s.platform = Gem::Platform::RUBY

  s.description = %q{Ting can convert between various phonetic representations of Mandarin Chinese. It can also handle various representation of tones, so it can be used to convert pinyin with numbers to pinyin with tones.}
  s.summary = %q{A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles.}

  s.files = ["History.txt", "README.rdoc", "Rakefile", "TODO"] + Dir["{lib,examples,test}/**/*.{rb,rhtml,csv,txt,yaml}"]
  s.require_paths = ["lib"]
  s.test_files = ["test/test_hanyu_coverage.rb", "test/test_comparison.rb"]

  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "History.txt", "TODO"]
  s.rdoc_options = ["--main", "README.rdoc"]

  s.rubygems_version = %q{1.2.0}
  s.specification_version = 2 if s.respond_to? :specification_version=
end
