ActiveAdmin.register Location do
  permit_params :name, :website, :contact_page, :phone, :email,
                :address_1, :address_2, :city, :zip, :lat, :long,
                :opening_date, :featured, :follow_up, :description,
                :handicap_status, :child_status, :pet_status, :state, :status, :author_id, category_ids: []
  index do
    column :id
    column :author
    column :status
    column :name
    column :city
    column :state
    actions
  end

  sidebar :categories, only: :show do
    ul do
      location.categories.each do |category|
        li category
      end
    end
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :description
      input :category_ids, as: :check_boxes, :collection => Category.order('name ASC').all
      input :handicap_status, as: :select, collection: Location.handicap_statuses.keys.map { |key| [(key.to_s[9..-1]).humanize, key]}, include_blank: false
      input :pet_status, as: :select, collection: Location.pet_statuses.keys.map { |key| [(key.to_s[4..-1]).humanize, key]}, include_blank: false
    end
    inputs 'Contact Info' do
      input :website, as: :url
      input :contact_page, as: :url
      input :phone
      input :email
    end
    inputs 'Address' do
      input :address_1
      input :address_2
      input :city
      input :state
      input :zip
      input :lat
      input :long
    end
    actions
  end

  controller do
    def create
      @author = current_user
      @location = Location.new(permitted_params[:location])
      @location.author = @author
      if @location.save
        redirect_to admin_location_path(@location), notice: t('flash.actions.create.notice', resource_name: Location.model_name.human)
      else
        render :new
      end
    end
  end
end
