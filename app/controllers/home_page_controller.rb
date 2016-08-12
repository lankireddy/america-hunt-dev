class HomePageController < ApplicationController
  def index
    @content_posts = Post.content_posts
    @categories = Category.all
    @species = Species.top_level
  end
end
