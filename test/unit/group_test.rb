require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < Test::Unit::TestCase
  fixtures :users, :groups

  def setup
    @group = Group.find(1)
    @user = User.find(1)
  end
  
  def test_fixture
    assert_kind_of(User, @user)
    assert_kind_of(Group, @group)
    assert_equal(@first_group.id, @group.id)
    assert_equal(@first_group.user_id, @group.user_id)
    assert_equal(@first_group.user_id, @user.id)
    assert_equal(@first_group.group_name, @group.group_name)
  end

  def test_group_users
    assert_equal(0,@group.members.size)
    @group = Group.find(1)
    @group.members.push(@another_user)
    @group.save
    assert_equal(1,@group.members.size)
    
    
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Group,  @group
  end
end
