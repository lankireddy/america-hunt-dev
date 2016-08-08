class HomePageController < ApplicationController
  def index
    @content_posts = Post.content_posts
  end
end
