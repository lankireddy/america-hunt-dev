ActiveAdmin.register Post do
  config.per_page = 300

  config.sort_order = 'position_asc'

  reorderable

  permit_params :title, :subtitle, :body, :position, :external_link, :featured_image, :featured_position, blog_category_ids: []

  #scope("Inactive") { |scope| scope.where(active: false) }

  scope :all, default: true

  BlogCategory.priority_categories.each do |bcat|
    scope(bcat.name) { |scope| scope.joins(:blog_category_posts).where(blog_category_posts: { blog_category_id: bcat.id }) }
  end
  
  index as: :reorderable_table do
    selectable_column
    column :id
    column :author
    column :created_at
    column :updated_at
    column :title
    column :featured_position do |post|
      post.featured_position.humanize
    end
    column :position
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
      row :featured_position do
        post.featured_position.humanize
      end
      row :position
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
      input :featured_position
      input :position
      input :body, as: :ckeditor
      input :external_link, as: :url
      if f.object.featured_image.present?
        input :featured_image, required: false, hint: image_tag(object.featured_image.url(:medium)).html_safe
      else
        input :featured_image
      end
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
