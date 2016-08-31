class PostsController < ApplicationController

  before_action :set_post, only: :show

  def index
    @page_title = 'America Hunt: Hunting News'
    @content_posts = Post.content_posts.page params[:page]
  end

  def sales
    @page_title = 'America Hunt: Hunting Sales'
    @link_posts = Post.link_posts.page params[:page]
  end

  def show
    @page_title = @post.title
    @page_description = @post.subtitle
  end

  private
    def set_post
      @post = Post.friendly.find(params[:id])
    end
end

