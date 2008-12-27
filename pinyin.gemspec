Gem::Specification.new do |s|
  s.name = %q{pinyin}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Arne Brasseur"]
  s.date = %q{2008-12-27}
  s.description = %q{Pinyin can convert between various systems for phonetically writing Mandarin Chinese. It can also handle various representation of tones, so it can be used to convert pinyin with numbers to pinyin with tones.}
  s.email = %q{pinyin@arnebrasseur.net}
  s.extra_rdoc_files = ["README.txt", "History.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "rakefile", "TODO", "examples/cgiform/cgiform.rb", "examples/cgiform/template.rhtml", "examples/hello.rb", "lib/pinyin.rb", "lib/pinyin/conversion.rb", "lib/pinyin/conversions.rb", "lib/pinyin/conversions/hanyu.rb", "lib/pinyin/data/comparison.csv", "lib/pinyin/data/final.csv", "lib/pinyin/data/initial.csv", "lib/pinyin/data/paladiy.txt", "lib/pinyin/data/rules.yaml", "lib/pinyin/data/valid_pinyin.yaml", "lib/pinyin/exception.rb", "lib/pinyin/groundwork.rb", "lib/pinyin/string.rb", "lib/pinyin/support.rb", "lib/pinyin/tones.rb", "lib/pinyin/tones/accents.rb", "lib/pinyin/tones/marks.rb", "lib/pinyin/tones/no_tones.rb", "lib/pinyin/tones/numbers.rb", "rakefile", "script/update", "test/test_comparison.rb", "test/test_hanyu_coverage.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://rubyforge.org/projects/pinyin}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pinyin}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles.}
  s.test_files = ["test/test_hanyu_coverage.rb", "test/test_comparison.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<facets>, [">= 2.4.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<facets>, [">= 2.4.0"])
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<facets>, [">= 2.4.0"])
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
