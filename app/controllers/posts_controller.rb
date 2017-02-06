class PostsController < ApplicationController
  before_action :set_post, only: :show
  before_action :set_blog_category, only: :index

  def index
    @menu_categories = BlogCategory.menu
    if @blog_category
      @page_title = 'America Hunt: ' + @blog_category.name
      # TODO: - should this be ignored if this is not a homepage category?
      @posts = @blog_category.posts.order(:position)
    else
      @page_title = 'America Hunt: Hunting News'
      @posts = Post.all
    end

    @posts = @posts.page params[:page]
  end

  def show
    @page_title = @post.title
    @page_description = @post.subtitle
  end

  private

    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def set_blog_category
      @blog_category = BlogCategory.friendly.find(params[:blog_category_id]) if params[:blog_category_id].present?
    end
end
