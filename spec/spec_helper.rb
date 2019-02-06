require "bundler/setup"
require "active_record/errors/localize"
require 'active_record'
require 'i18n'
require 'pry'
require 'nulldb_rspec'
include NullDB::RSpec::NullifiedDatabase

NullDB.configure do |c|
  c.project_root = File.expand_path("#{__FILE__}/..")
end
ActiveRecord::Base.configurations.merge!('test' =>  { adapter: 'nulldb' })

I18n.load_path << Dir[File.expand_path("config/locales_examples") + "/*.yml"]
I18n.default_locale = :ja

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
