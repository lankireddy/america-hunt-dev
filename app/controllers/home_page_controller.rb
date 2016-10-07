class HomePageController < ApplicationController
  STORY_LIMIT = 7

  def index
    @content_posts = Post.content_posts.limit(STORY_LIMIT)
    @categories = Category.all
    @videos = HomepageVideo.published.order(:order)
  end
end
