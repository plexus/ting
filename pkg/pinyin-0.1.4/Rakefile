require 'rubygems'

require 'rake'
require 'rake/testtask'
require 'hoe'

$:.unshift './lib'

require 'pinyin'

Hoe.new('pinyin', Pinyin::VERSION) do |p|
  p.rubyforge_name = 'pinyin'
  p.summary = "A conversion library for Chinese transcription methods like Hanyu Pinyin, Bopomofo and Wade-Giles"
  p.description = p.paragraphs_of('README', 2).join
  p.url = "http://rubyforge.org/projects/pinyin"
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.email = "pinyin@arnebrasseur.net"
  p.author = 'Arne Brasseur'
  p.remote_rdoc_dir=""
  p.spec_extras = {
    :extra_rdoc_files => ["README", "History.txt"],
    :rdoc_options => ["--main", "README"],
    :platform => Gem::Platform::RUBY
  }
end

task :default => [:test_units]

namespace "test" do
  Rake::TestTask.new("pinyin") do |t|
    $: << File.dirname(__FILE__) + '/lib'
    t.pattern = 'test/*.rb'
    t.verbose = true
    t.warning = true
  end
end
