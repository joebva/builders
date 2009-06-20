require File.join(File.dirname(__FILE__), '..', 'test_helper')

class BadgeTest < ActiveSupport::TestCase
  
  should_have_db_column :name, :type => "string"
  should_have_db_column :description, :type => "text"

  should_validate_presence_of :name, :description

  
end
