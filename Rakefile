$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "inherited_views/version"
require 'rake/testtask'
 
desc "Builds the gem"
task :build do
  system "gem build inherited_views.gemspec"
end
 
desc "Creates a new release of the gem"
task :release => :build do
  system "gem push inherited_views-#{InheritedViews::VERSION}"
end

Rake::TestTask.new :test do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end