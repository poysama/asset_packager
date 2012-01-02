require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

namespace :spec do
  task :prep_rails1 do
    puts 'Preparing environment for Rails 1.x RSpec code examples'
    ENV['RAILS_VERSION'] = '1'
    `bundle`
    `rvm use ree-1.8.7`
  end

  task :prep_rails2 do
    puts 'Preparing environment for Rails 2.x RSpec code examples'
    ENV['RAILS_VERSION'] = '2'
    `bundle`
    `rvm use ruby-1.9.2`
  end

  desc 'Run RSpec code examples for Rails 1.x compatibility'
  RSpec::Core::RakeTask.new do |t|
    t.name    = 'rails1'
  end

  desc 'Run RSpec code examples for Rails 2.x compatibility'
  RSpec::Core::RakeTask.new do |t|
    t.name    = 'rails2'
  end

  Rake::Task[:rails1].enhance [:store_rvm_env, :prep_rails1] do
    Rake::Task[:load_rvm_env].invoke
  end

  Rake::Task[:rails2].enhance [:store_rvm_env, :prep_rails2] do
    Rake::Task[:load_rvm_env].invoke
  end
end

task :store_rvm_env do
  puts 'Storing RVM environment'
  @rvm_env = `rvm current`
end

task :load_rvm_env do
  puts 'Loading stored RVM environment'
  `rvm use #{@rvm_env}`
end

desc 'Run RSpec code examples'
task :spec        => ["spec:rails1", "spec:rails2"]
task :default     => [:spec]
