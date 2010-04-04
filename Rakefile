require 'rubygems'

require 'rake'
require 'rake/testtask'

task :default => [:test_units]

namespace "test" do
  Rake::TestTask.new("ting") do |t|
    $: << File.dirname(__FILE__) + '/lib'
    t.pattern = 'test/*.rb'
    t.verbose = true
    t.warning = true
  end
end
