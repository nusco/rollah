require "bundler/setup"
require "rspec/core/rake_task"

desc "run specs"
RSpec::Core::RakeTask.new

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
 t.cucumber_opts = ["--format pretty"]
end

task :test => ["cucumber", "spec"]
task :default => "test"
