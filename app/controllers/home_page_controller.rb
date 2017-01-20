class HomePageController < ApplicationController
  def index
    @widget_categories = BlogCategory.widget.includes(:posts)
    @name_only_categories = BlogCategory.name_only
    @videos = HomepageVideo.published.order(:order)
  end

  def new_home
    set_categories
    if @primary_category
      collate_posts_for_home
    else
      @posts = Post.all.limit(10)
    end
  end

  def set_categories
    @primary_category = BlogCategory.primary_category
    @wildlife_category = BlogCategory.wildlife_category
    @hunting_org_category = BlogCategory.hunting_org_category
    @field_notes_from_game_wardens_category = BlogCategory.field_notes_from_game_wardens_category
    @secondary_featured_categories = [@field_notes_from_game_wardens_category, @wildlife_category]
  end

  def collate_posts_for_home
    @featured_ids = []
    [:primary_featured, :secondary_featured_one, :secondary_featured_two, :secondary_featured_three].each do |key|
      featured_post = featured_post(key)
      instance_variable_set("@#{key}", featured_post)
      @featured_ids << featured_post.id if featured_post
    end
    @posts = not_used.order(:position).limit(10)
  end

  def not_used
    @primary_category.posts.where.not(id: @featured_ids)
  end

  def featured_post(key)
    Post.with_featured_position(key).first || not_used.order(:position).limit(1).first
  end
end
