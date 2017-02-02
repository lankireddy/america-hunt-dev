class HomePageController < ApplicationController
  before_action :set_categories, only: :new_home
  def index
    @widget_categories = BlogCategory.widget.includes(:posts)
    @name_only_categories = BlogCategory.name_only
    @videos = HomepageVideo.published.order(:order)
  end

  def new_home
    if @primary_category
      collate_posts_for_home
    else
      @posts = Post.all.limit(10).includes(:posts)
    end
  end

  def collate_posts_for_home
    [:primary_featured, :secondary_featured_one, :secondary_featured_two, :secondary_featured_three].each do |key|
      instance_variable_set("@#{key}", @primary_category.featured_post(key))
    end
    @posts = @primary_category.not_already_used.order(:position).limit(10).includes(:posts)
  end

  private
    def set_categories
      @primary_category = BlogCategory.widget.first
      @under_widget_text_link_categories = BlogCategory.under_widget_text_link
      @secondary_featured_categories = BlogCategory.secondary_featured
    end
end
