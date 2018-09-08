require "bundler/gem_tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.rspec_opts = "--color"
  t.rspec_opts = "--require ./lib/rspec-tick-formatter.rb --format RspecTickFormatter --color"
  t.fail_on_error = false
end
