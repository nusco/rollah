require "bundler/setup"

desc "run tests"
task :test do
  # intentionally segregated to avoid Heroku complaining
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new
end

task :default => "test"
