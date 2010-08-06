require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "lesstidy"
    gem.summary = "CSS formatting tool"
    gem.description = "LessTidy takes your CSS (or LessCSS) file and rewrites it in a more readable format."
    gem.email = "rico@sinefunc.com"
    gem.homepage = "http://github.com/rstacruz/lesstidy"
    gem.authors = ["Rico Sta. Cruz", "Sinefunc, Inc."]
    gem.add_dependency "treetop"
    gem.add_development_dependency "contest"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lesstidy #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

def say_status(what, status, priority=0)
  color = 32
  color = 30  if priority == -1
  color = 31  if priority == 1
  status.gsub!(ENV['HOME'], '~')
  status += "/"  if File.directory?(File.expand_path(status))
  puts "\033[1;#{color}m%20s\033[0m  %s" % [what, status]
end

def create_fixture_file(fname, lt_options)
  cmd = "./bin/lesstidy #{lt_options} > \"#{fname}\""
  if File.exists?(fname)
    say_status :skip, fname, -1
  else
    say_status :create, fname
    system(cmd)
  end
end

task :create_fixtures do
  path = 'test/fixtures'
  Dir["#{path}/*.control.css"].each do |file|
    basename = File.basename(file)
    name = basename.split('.')[0]

    create_fixture_file "#{path}/#{name}.inspect.txt", "-d \"#{file}\""
    ['column', 'default', 'terse', 'column-80'].each do |preset|
      create_fixture_file "#{path}/#{name}.#{preset}.css", "--preset=#{preset} \"#{file}\""
    end
  end
end
