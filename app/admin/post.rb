ActiveAdmin.register Post do
  permit_params :title, :subtitle, :body

  index do
    column :id
    column :author
    column :created_at
    column :updated_at
    column :title
    actions
  end

  form do |f|
    inputs 'Details' do
      input :title
      input :subtitle
      input :body, as: :ckeditor
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