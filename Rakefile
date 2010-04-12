$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "inherited_views/version"
 
task :build do
  system "gem build inherited_views.gemspec"
end
 
task :release => :build do
  system "gem push inherited_views-#{InheritedViews::VERSION}"
end