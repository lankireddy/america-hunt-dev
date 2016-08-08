ActiveAdmin.register Post do
  permit_params :title, :subtitle, :body, blog_category_ids: []

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

  form do |f|
    inputs 'Details' do
      input :title
      input :subtitle
      input :body, as: :ckeditor
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