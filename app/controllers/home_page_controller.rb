class HomePageController < ApplicationController
  def index
    @widget_categories = BlogCategory.widget.includes(:posts)
    @name_only_categories = BlogCategory.name_only
    @videos = HomepageVideo.published.order(:order)
  end

  def new_home
    collate_posts_for_home

  end

  def collate_posts_for_home
    @primary_category = BlogCategory.primary_category

    if @primary_category
      featured_ids = []

      @primary_featured = Post.with_featured_position(:primary_featured).first || @primary_category.posts.order(:position).limit(1).first
      featured_ids << @primary_featured.id if @primary_featured
      @secondary_featured_one = Post.with_featured_position(:secondary_featured_one).first || @primary_category.posts.where.not(id: featured_ids).order(:position).limit(1).first
      featured_ids << @secondary_featured_one.id if @secondary_featured_one
      @secondary_featured_two = Post.with_featured_position(:secondary_featured_two).first || @primary_category.posts.where.not(id: featured_ids).order(:position).limit(1).first
      featured_ids << @secondary_featured_two.id if @secondary_featured_two
      @secondary_featured_three = Post.with_featured_position(:secondary_featured_three).first || @primary_category.posts.where.not(id: featured_ids).order(:position).limit(1).first
      featured_ids << @secondary_featured_three.id if @secondary_featured_three

      @posts = @primary_category.posts.where.not(id: featured_ids).order(:position).limit(10)
    else
      @primary_featured = nil
      @secondary_featured_one = nil
      @secondary_featured_two = nil
      @secondary_featured_three = nil
      @posts = Post.all.limit(10)
    end
  end

end
