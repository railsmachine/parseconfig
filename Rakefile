require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "parseconfig"
  gem.homepage = "http://github.com/eMxyzptlk/parseconfig"
  gem.license = "MIT"
  gem.summary = %Q{parseconfig is a Ruby class to parse simple configuration files}
  gem.description = %Q{parseconfig is a Ruby class written to parse simple configuration files in the format of 'param = value'. The key benefit is that your ruby scripts can use the same configuration files of most unix/linux applications.}
  gem.authors = `git log --pretty=format:"%an <%ae>"`.split("\n").uniq.sort.collect { |a| r = /\A(.*) <(.*)>\z/.match(a); r[1] }
  gem.email   = `git log --pretty=format:"%an <%ae>"`.split("\n").uniq.sort.collect { |a| r = /\A(.*) <(.*)>\z/.match(a); r[2] }
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "parseconfig #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end