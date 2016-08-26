class PostsController < ApplicationController

  before_action :set_post, only: :show

  def index
    @content_posts = Post.content_posts
  end

  def sales
    @link_posts = Post.link_posts
  end

  def show
    @page_title = @post.title
    @body_classes = 'margin-header' unless @post.featured_image.present?
  end

  private
    def set_post
      @post = Post.friendly.find(params[:id])
    end
end

