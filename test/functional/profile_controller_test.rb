require File.dirname(__FILE__) + '/../test_helper'
require 'profile_controller'
require 'login_controller'

# Re-raise errors caught by the controller.
class ProfileController; def rescue_action(e) raise e end; end

class ProfileControllerTest < Test::Unit::TestCase
  fixtures :users

  def setup
    @controller = ProfileController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_redirect "login"
  end

  def test_show
    @request.session[:user] = @first_user
    get :show
    assert_response :success
    assert_rendered_file 'show'
    assert_template_has 'user'
    assert_valid_record 'user'
  end

  def test_new
    get :new
    assert_rendered_file 'new'
    assert_template_has 'user'
  end

#  def test_create
#    num_users = User.find_all.size
#
#    post :create, 'user' => { :username => "testuser", :password => "password"}
#    assert_redirected_to :controller => 'welcome'
#
#    assert_equal num_users + 1, User.find_all.size
#  end
#
#  def test_edit
#    get :edit, 'id' => 1
#    assert_rendered_file 'edit'
#    assert_template_has 'user'
#    assert_valid_record 'user'
#  end

#  def test_update
#    post :update
#    assert_redirected_to :controller => 'welcome'
#  end

#  def test_destroy
#    assert_not_nil User.find(1)
#
#    post :destroy, 'id' => 1
#    assert_redirected_to :action => 'list'
#
#    assert_raise(ActiveRecord::RecordNotFound) {
#      user = User.find(1)
#    }
#  end
end
