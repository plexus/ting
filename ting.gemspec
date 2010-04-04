$:.unshift './lib'

require 'ting'

Gem::Specification.new do |s|
  s.name = "ting"
  s.authors = ["Arne Brasseur"]
  s.email = ["arne@arnebrasseur.net"]
  s.homepage = %q{http://github.com/arnebrasseur/ting}

  s.version = Ting::VERSION
  s.date = %q{2010-04-04}
  s.platform = Gem::Platform::RUBY

  s.description = %q{Ting can convert between various systems for phonetically writing Mandarin Chinese. It can also handle various representation of tones, so it can be used to convert pinyin with numbers to pinyin with tones.}
  s.summary = %q{A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles.}

  s.files = ["History.txt", "README.rdoc", "Rakefile", "TODO", "examples/cgiform/cgiform.rb", "examples/cgiform/template.rhtml", "examples/hello.rb", "lib/ting.rb", "lib/ting/conversion.rb", "lib/ting/conversions.rb", "lib/ting/conversions/hanyu.rb", "lib/ting/data/comparison.csv", "lib/ting/data/final.csv", "lib/ting/data/initial.csv", "lib/ting/data/paladiy.txt", "lib/ting/data/rules.yaml", "lib/ting/data/valid_pinyin.yaml", "lib/ting/exception.rb", "lib/ting/groundwork.rb", "lib/ting/string.rb", "lib/ting/support.rb", "lib/ting/tones.rb", "lib/ting/tones/accents.rb", "lib/ting/tones/supernum.rb", "lib/ting/tones/ipa.rb", "lib/ting/tones/marks.rb", "lib/ting/tones/no_tones.rb", "lib/ting/tones/numbers.rb", "test/test_comparison.rb", "test/test_hanyu_coverage.rb"]
  s.require_paths = ["lib"]
  s.test_files = ["test/test_hanyu_coverage.rb", "test/test_comparison.rb"]

  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "History.txt"]
  s.rdoc_options = ["--main", "README.rdoc"]

  s.rubygems_version = %q{1.2.0}
  s.specification_version = 2 if s.respond_to? :specification_version=
end
