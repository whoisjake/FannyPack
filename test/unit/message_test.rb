require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < Test::Unit::TestCase
  fixtures :users, :groups, :messages

  def setup
    @message = Message.find(1)
    @user = User.find(1)
  end
  
  def test_user_messages
    assert_equal(1,@user.messages.size)
    @message = Message.find(1)
    @user.messages.push(@first_message)
    assert_equal(2,@user.messages.size)
    
    @first_group.members.push(@another_user)
    assert(@first_group.save)
    
    assert_equal(0,@another_user.get_people_messages.size)
    assert_equal(0,@first_group.messages.size)
    @message.groups.push(@first_group)
    assert(@message.save)
    assert(@first_group.save)
    @first_group.reload
    assert_equal(1,@first_group.messages.size)
    assert_equal(1,@message.groups.size)
    #@another_user.reload
    #assert_equal(1,@another_user.get_people_messages.size, "People Message")
    
    
    
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Message,  @message
  end
end
