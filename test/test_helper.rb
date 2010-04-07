ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'

require File.expand_path(File.dirname(__FILE__) + "/../spec/blueprints")
require "authlogic/test_case"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  setup {
    Sham.reset
    eval (File.open(File.join(Rails.root, 'db', 'seeds.rb'), "r").read)
    quietly { Document::DOCUMENT_CACHE = File.join(Rails.root, "tmp", "test_documents") }
  }
  
  teardown {
    FileUtils.rm_r(Document::DOCUMENT_CACHE) if File.exists?(Document::DOCUMENT_CACHE)
  }
end

class TestDocument
  attr_accessor :original_filename, :file_contents, :content_type
  
  def read
    @file_contents
  end
end

def admin_setup
  activate_authlogic
  
  test_image = TestDocument.new
  test_image.original_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'samples', 'jet_trails.jpg'))
  test_image.content_type = 'image/jpeg'
  test_image.file_contents = File.open(test_image.original_filename, "r").read
  
  @catalog = Catalog.make
  
  @document = Document.new(Document.plan(:empty))
  @document.document = test_image
  @document.save!
  
  UserSession.create( { :email => "example@example.com", :password => "changeme" } )
end

def quietly
  v = $VERBOSE
  $VERBOSE = nil
  yield
  ensure
    $VERBOSE = v
end
