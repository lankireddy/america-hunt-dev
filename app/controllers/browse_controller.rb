class BrowseController < ApplicationController
  def index
    @widget_categories = BlogCategory.widget.includes(:posts)
    @name_only_categories = BlogCategory.name_only
    @videos = HomepageVideo.published.order(:order)
  end
end
