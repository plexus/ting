$:.unshift './lib'

require 'ting'

Gem::Specification.new do |s|
  s.name = "ting"
  s.version = Ting::VERSION
  s.authors = ["Arne Brasseur"]
  #s.date = %q{2010-01-31}
  s.description = "A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles"
  s.email = ["arne@arnebrasseur.net"]
  s.extra_rdoc_files = ["README.rdoc", "History.txt"]
  s.files = ["README.rdoc", "lib"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/arnebrasseur/ting}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Handle and convert transcriptions of Mandarin Chinese (e.g. pinyin).}
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.platform = Gem::Platform::RUBY
  #s.add_dependency("<gemname>", [">= xx.yy"])
end
