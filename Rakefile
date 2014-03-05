require 'rubygems'
require 'pathname'

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'rubygems/package_task'
task :default   => :all_tests
task :all_tests => [:test, :spec]

Rake::TestTask.new(:test) do |t|
  $: << File.dirname(__FILE__) + '/lib'
  t.pattern = 'test/*.rb'
  #t.verbose = true
  #t.warning = true
end

RSpec::Core::RakeTask.new(:spec)

spec = Gem::Specification.load(Pathname.glob('*.gemspec').first.to_s)
Gem::PackageTask.new(spec).define

desc "Push gem to rubygems.org"
task :push => :gem do
  sh "git tag v#{Ting::VERSION}"
  sh "git push --tags"
  sh "gem push pkg/hexp-#{Ting::VERSION}.gem"
end
