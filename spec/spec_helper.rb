# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'rspec/rails'

require File.expand_path(File.dirname(__FILE__) + "/blueprints")

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Rspec.configure do |config|
  # Remove this line if you don't want Rspec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include Rspec::Matchers

  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # == Fixtures
  #
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  #
  # config.use_transactional_fixtures = true
  # config.use_instantiated_fixtures  = false
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Notes
  #
  # For more information take a look at Rspec::Core::Configuration
  
  config.before(:all) do
    Sham.reset(:before_all)
    eval (File.open(File.join(Rails.root, 'db', 'seeds.rb'), "r").read)
    quietly { Document::DOCUMENT_CACHE = File.join(Rails.root, "tmp", "test_documents") }
  end
  
  config.before(:each) { Sham.reset(:before_each) }
  
  config.after(:all) { FileUtils.rm_r(Document::DOCUMENT_CACHE) if File.exists?(Document::DOCUMENT_CACHE) }
end

# This method has been added to allow warnings to be supressed.

def quietly
  v = $VERBOSE
  $VERBOSE = nil
  yield
  ensure
    $VERBOSE = v
end
