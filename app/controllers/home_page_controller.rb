class HomePageController < ApplicationController
  def index
    @content_posts = Post.content_posts
    @link_posts = Post.link_posts
    @categories = Category.all
    @species = Species.top_level
  end
end
