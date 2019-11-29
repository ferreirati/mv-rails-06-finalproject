require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'post interface' do
    @user = users(:one)
    sign_in @user
    get root_path
    assert_template 'static_pages/home'
    assert_select 'textarea#post_content'

    new_post_content = 'Lorem ipsum dolor sit amet'
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: new_post_content } }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_match new_post_content, response.body
    assert_not flash.empty?
    assert_equal"Post created.", flash[:success]
  end
end