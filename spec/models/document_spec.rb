require 'spec_helper'

class TestDocument
  attr_accessor :original_filename, :file_contents, :content_type
  
  def read
    @file_contents
  end
end

describe Document do
  before do
    @test_image = TestDocument.new
    @test_image.original_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', 'samples', 'jet_trails.jpg'))
    @test_image.content_type = 'image/jpeg'
    @test_image.file_contents = File.open(@test_image.original_filename, "r").read
    
    @test_file = TestDocument.new
    @test_file.original_filename = File.expand_path(__FILE__)
    @test_file.content_type = 'text/plain'
    @test_file.file_contents = File.open(@test_file.original_filename, "r").read
    
    @test_alt = TestDocument.new
    @test_alt.original_filename = File.expand_path(File.join(File.dirname(__FILE__), '..', 'samples', 'oil_drops.jpg'))
    @test_alt.content_type = 'image/jpeg'
    @test_alt.file_contents = File.open(@test_alt.original_filename, "r").read
  end
  
  def create_document(object)
    document = Document.new(Document.plan(:empty))
    document.document = object
    document.save!
    document
  end
  
  it "should not create a new document" do
    lambda { Document.make(:empty) }.should raise_error(ActiveRecord::RecordInvalid)
  end
  
  it "should create a new document" do
    lambda {
      create_document(@test_image)
    }.should change(Document, :count).by(1)
  end
  
  it "should persist the document, no thumbnail" do
    document_count = Dir.glob(File.join(Document::DOCUMENT_CACHE, '*')).size
    thumbnail_count = Dir.glob(File.join(Document::THUMBNAIL_CACHE, '*')).size

    document = create_document(@test_file)

    document_count.should < Dir.glob(File.join(Document::DOCUMENT_CACHE, '*')).size
    thumbnail_count.should == Dir.glob(File.join(Document::THUMBNAIL_CACHE, '*')).size
  end
  
  it "should persist the image, with thumbnail" do
    document = create_document(@test_alt)
    
    File.exists?(File.join(Document::THUMBNAIL_CACHE, document.signature)).should == true
    File.exists?(File.join(Document::DOCUMENT_CACHE, document.signature)).should == true
  end
  
  it "should not duplicate the files in the file system" do
    document_count = Dir.glob(File.join(Document::DOCUMENT_CACHE, '*')).size
    thumbnail_count = Dir.glob(File.join(Document::THUMBNAIL_CACHE, '*')).size
    
    lambda {
      create_document(@test_alt)
    }.should change(Document, :count).by(1)
    
    document_count.should == Dir.glob(File.join(Document::DOCUMENT_CACHE, '*')).size
    thumbnail_count.should == Dir.glob(File.join(Document::THUMBNAIL_CACHE, '*')).size
  end
  
  it "should be an image" do
    document = create_document(@test_image)
    document.image?.should == true
  end
  
  it "should not be an image" do
    document = create_document(@test_file)
    document.image?.should == false
  end
  
  it "should return file path" do
    document = create_document(@test_image)
    File.exists?(document.file).should == true
  end
  
  it "should return thumbnail path" do
    document = create_document(@test_image)
    File.exists?(document.thumbnail).should == true
  end
  
  it "should not throw duplicate errors" do
    count = 10
    lambda {
      count.times { |i| create_document(@test_file) }
    }.should change(Document, :count).by(10)
  end
  
  it "should not delete the base file while records exist" do
    create_document(@test_file)
    document = create_document(@test_file)
    signature = document.signature
    
    File.exists?(File.join(Document::DOCUMENT_CACHE, signature)).should == true
    document.destroy
    File.exists?(File.join(Document::DOCUMENT_CACHE, signature)).should == true
  end
  
  it "should delete the base file when no records exist" do
    create_document(@test_file)
    document = create_document(@test_file)
    signature = document.signature
    
    File.exists?(File.join(Document::DOCUMENT_CACHE, signature)).should == true
    
    Document.all.each do |document|
      document.destroy
    end
    
    File.exists?(File.join(Document::DOCUMENT_CACHE, signature)).should == false
  end
end
