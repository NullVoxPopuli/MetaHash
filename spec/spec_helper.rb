
require "rubygems"
require "bundler/setup"

require "pry-byebug" # binding.pry to debug!

# Coverage
require "codeclimate-test-reporter"
ENV['CODECLIMATE_REPO_TOKEN'] = "1d1b1a31bb3137d986297ad8a1ad5a3a1adbd70f0e8583d7eaf1dd4c0ab0bbe1"
CodeClimate::TestReporter.start

# This Gem
require "metahash"


ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load File.dirname(__FILE__) + '/support/schema.rb'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each {|file| require file }




# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
