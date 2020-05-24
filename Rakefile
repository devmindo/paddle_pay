# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_spec.rb']
  t.verbose = true
end

desc 'Run tests'
task default: :test
