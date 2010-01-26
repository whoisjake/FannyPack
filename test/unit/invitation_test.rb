require File.dirname(__FILE__) + '/../test_helper'

class InvitationTest < Test::Unit::TestCase
  fixtures :users, :groups, :invitations

  def setup
    @invitation = Invitation.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Invitation,  @invitation
  end
  
  def test_user_request
    assert_equal(2,@first_user.invitations.count)
    invitation = Invitation.new
    invitation.user = @first_user
    invitation.group = @another_group
    invitation.save
    assert_equal(3,@first_user.invitations.count)
  end
end
