require 'rubygems'

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'

task :default   => :all_tests
task :all_tests => [:test, :spec]

Rake::TestTask.new(:test) do |t|
  $: << File.dirname(__FILE__) + '/lib'
  t.pattern = 'test/*.rb'
  #t.verbose = true
  #t.warning = true
end

RSpec::Core::RakeTask.new(:spec)
