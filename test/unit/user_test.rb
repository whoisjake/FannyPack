require File.dirname(__FILE__) + '/../test_helper'
require "digest/sha1" 

class UserTest < Test::Unit::TestCase
  fixtures :users, :groups, :invitations
  
  def setup
    @user = User.find(1)
  end
  
  def test_fixture
    assert_kind_of(User, @user)
    assert_equal(@first_user.username, @user.username)
    assert_equal(@first_user.first_name, @user.first_name)
    assert_equal(@first_user.last_name, @user.last_name)
    assert_equal(@first_user.email, @user.email)
    assert_equal(@first_user.address1, @user.address1)
    assert_equal(@first_user.address2, @user.address2)
    assert_equal(@first_user.city, @user.city)
    assert_equal(@first_user.zip_code, @user.zip_code)
  end
  
  def test_get_user_by_invalid_login
    assert_nil(User.get_user_by_login(nil,nil))
    assert_nil(User.get_user_by_login("",""))
    assert_nil(User.get_user_by_login('kdkdkdkdk','kdkdkdkdkdk'))
  end
  
  def test_get_user_by_login
    assert_equal(@first_user, User.get_user_by_login(@first_user.username,'password'))
  end

  def test_hashedpassword
    assert_equal(@first_user.password,nil)
    assert_equal(@first_user.hashed_password,Digest::SHA1.hexdigest('password'))
  end
  
  def test_update_activity_timestamp
    user = User.new
    user.username = "asdf"
    user.password = "asdf"
    user.last_activity = "2005-01-26 00:00:00"
    assert(user.save)
    user.reload
    user.update_activity_timestamp()
    assert(user.save)
    assert_not_equal("2005-01-26 00:00:00",user.last_activity.strftime("%Y-%m-%d %H:%M:%S"))
  end
  
  def test_get_groups
    assert_equal(1,@first_user.groups.count)
    assert_equal(2,@another_user.groups.count)
  end
  
  def test_find_logged_in_users
#    user = User.new
#    user.username = "asdf"
#    user.password = "asdf"
#    user.last_activity = "2005-01-26 00:00:00"
#    user.save
#    
#    @group = @first_group
#    
#    assert_equal(0,@first_user.get_logged_in_users.size)
#    @group.members.push(@another_user)
#    assert(@group.save)
#    @group.reload
#    assert_equal(1,@group.members.size,"User wasn't added")
# #   @first_group.members.push(@another_user)
# #   assert_equal(1,@first_group.members.size,"foo")
# #   assert(@first_group.save,"Save Group")
#  #  assert_equal(0,@first_user.get_logged_in_users.size)
#    user.update_activity_timestamp()    
#    assert(user.save,"Save User")
#    user.reload
#    assert_equal(1,user.last_activity)
#    assert_equal(1,@first_user.get_logged_in_users,"bar")
#    #@first_user.get_logged_in_users
  end
  
  def test_user_has_access
    assert(!@first_user.has_access_to_user_id(@second_user))
    @first_group.members.push(@another_user)
    assert(@first_group.save)
    #assert(@first_user.has_access_to_user_id(@another_user))
  end
  

  # Replace this with your real tests.
  def test_truth
    assert_kind_of User,  @user
  end
end
