class HomePageController < ApplicationController
  def index
    @content_posts = Post.content_posts.limit(5)
    @link_posts = Post.link_posts.limit(5)
    @categories = Category.all
    @species = Species.top_level
    @videos = HomepageVideo.published.order(:order)
  end
end
