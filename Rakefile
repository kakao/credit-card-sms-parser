require 'bundler/gem_tasks'
require 'rake/testtask'
require 'bump/tasks'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
  #t.pattern = "spec/*_spec.rb"
  t.verbose = true
end

desc 'Run tests'
task :default => :test