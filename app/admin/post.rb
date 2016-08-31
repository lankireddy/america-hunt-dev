ActiveAdmin.register Post do
  scope :all, default: true
  scope :link_posts
  scope :content_posts

  permit_params :title, :subtitle, :body, :external_link, :featured_image, blog_category_ids: []

  index do
    column :id
    column :author
    column :created_at
    column :updated_at
    column :title
    actions
  end

  sidebar :categories, only: :show do
    ul do
      post.blog_categories.each do |category|
        li link_to(category, admin_blog_category_path(category))
      end
    end
  end

  show do
    attributes_table do
      row :title
      row :subtitle
      row :body
      row :external_link
      row :featured_image do
        image_tag post.featured_image.url(:medium), class: 'featured-image'
      end
    end
  end
  form do |f|
    inputs 'Details' do
      input :title
      input :subtitle
      input :body, as: :ckeditor
      input :external_link, as: :url
      input :featured_image
      input :blog_category_ids, as: :check_boxes, :collection => BlogCategory.order('name ASC').all
    end
    actions
  end

  controller do
    def create
      @author = current_admin_user
      @post = Post.new(permitted_params[:post])
      @post.author = @author
      if @post.save
        redirect_to admin_post_path(@post), notice: t('flash.actions.create.notice', resource_name: Post.model_name.human)
      else
        render :new
      end
    end
    def find_resource
      Post.friendly.find(params[:id])
    end
  end
end