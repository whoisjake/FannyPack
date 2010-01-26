require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :users, :groups,:events

  def setup
    @event = User.find(1)
    @event = Event.find(1)
  end
  
  def test_user_events
#    assert_equal(1,@user.events.size)
#    @event = Event.find(1)
#    @user.events.push(@first_event)
#    assert_equal(2,@user.events.size)
    
  end
  
  def test_events_many_to_many
    @event = Event.find(1)

    assert_equal(0,@another_user.get_people_events.size)
    
    assert_equal(0,@first_group.events.size)
    @event.groups.push(@first_group)
    assert(@event.save)
    assert(@first_group.save)
    @first_group.reload
    assert_equal(1,@first_group.events.size)
    assert_equal(1,@event.groups.size)
    
    assert_equal(1,@another_user.get_people_events.size)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Event,  @event
  end
end
