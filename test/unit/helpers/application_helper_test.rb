require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def current_user
    true
  end
  
  setup :document_setup
  
  test "application name" do
    name = application_name
    assert_equal "Chroma32", name
  end
  
  test "user plugin links" do
    links = user_plugin_links
    links.each do |link|
      assert_match /<a href=".*/, link
    end
  end
  
  test "admin plugin links" do
    links = admin_plugin_links
    links.each do |link|
      assert_match /<a href=".*/, link
    end
  end
  
  test "file path generation" do
    path = file_path(@document)
    assert_equal "/download/1/file/jet_trails.jpg", path
  end
  
  test "thumbnail path generation" do
    path = thumbnail_path(@document)
    assert_equal "/download/1/thumbnail/jet_trails.jpg", path
  end
end
