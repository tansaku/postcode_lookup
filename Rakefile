# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

unless Rails.env.production?

  require "rubocop/rake_task"
  require "rspec/core/rake_task"

  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ["--display-cop-names", "-a"]
  end

  RSpec::Core::RakeTask.new(:rspec)

  # desc "test performance of algorithm against ruby default implementation"
  # task :performance do
  #   require "./performance"
  # end

  task default: %i[rubocop rspec]
end
