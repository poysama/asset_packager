require 'rubygems'
gem 'echoe'
require 'echoe'

Echoe.new("asset_packager") do |p|
  p.author = "palmade"
  p.project = "palmade"
  p.summary = "An asset_packager for use with Rails and other frameworks"

  p.need_tar_gz = false
  p.need_tgz = true

  p.clean_pattern += ["pkg", "lib/*.bundle", "*.gem", ".config"]
  p.rdoc_pattern = ['README', 'LICENSE', 'COPYING', 'lib/**/*.rb', 'doc/**/*.rdoc']
end

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
