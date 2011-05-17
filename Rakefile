require "rake/testtask"
require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default, :development)

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

begin
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "appfigures"
    gemspec.summary = "AppFigures API"
    gemspec.description = "AppFigures API ruby edition"
    gemspec.email = "francis@ignition.hk"
    gemspec.homepage = "https://github.com/siuying/appfigures"
    gemspec.authors = ["Francis Chong"]
  end
  Jeweler::GemcutterTasks.new

rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end