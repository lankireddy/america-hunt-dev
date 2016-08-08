ActiveAdmin.register Page do
  permit_params :title, :body

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
      input :body, as: :ckeditor
    end
    actions
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