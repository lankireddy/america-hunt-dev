ActiveAdmin.register Page do
  permit_params :title, :body, :slug, :featured_image, :caption, :display_newsletter_sign_up

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
      input :slug
      input :body, as: :ckeditor
      if object.featured_image.present?
        input :featured_image, required: false, hint: image_tag(object.featured_image.url(:medium)).html_safe
      else
        input :featured_image
      end
      input :caption
      input :display_newsletter_sign_up
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :featured_image do
        image_tag page.featured_image.url(:medium), class: 'featured-image'
      end
      row :caption
      row :body
      row :created_at
      row :slug
      row :author
    end
    active_admin_comments
  end

  controller do
    def create
      @author = current_admin_user
      @page = Page.new(permitted_params[:page])
      @page.author = @author
      if @page.save
        redirect_to admin_page_path(@page), notice: t('flash.actions.create.notice', resource_name: Page.model_name.human)
      else
        render :new
      end
    end
    def find_resource
      Page.friendly.find(params[:id])
    end
  end
end
