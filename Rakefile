require 'bundler/gem_tasks'

gem 'rspec'
require 'spec/rake/spectask'

desc "Test AssetPackager on Rails 1"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/*.rb'].exclude('spec/spec_helper.rb')
  t.spec_opts.push("-f s")
end

desc "Test AssetPackager on Rails 2"
Spec::Rake::SpecTask.new do |t|
  t.name = 'spec2'
  t.spec_files = FileList['spec/rails2_tests/*.rb']
  t.spec_opts.push("-f s")
end

task :default => [ :spec, :spec2 ]
