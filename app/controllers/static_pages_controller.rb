class StaticPagesController < ApplicationController
  def home
    @post = current_user.posts.build
    @posts = Post.order(created_at: :desc)
  end
end
