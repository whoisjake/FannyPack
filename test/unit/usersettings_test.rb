require File.dirname(__FILE__) + '/../test_helper'

class UsersettingsTest < Test::Unit::TestCase
  fixtures :users, :usersettings

  def setup
    @usersettings = Usersettings.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Usersettings,  @usersettings
  end
  
  def test_user_settings
    assert_equal("http://www.myblog.com",@first_user.usersettings.blogurl)
  end
end
