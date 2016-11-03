ActiveAdmin.register Location do
  config.per_page = 60

  scope :approved, default: true
  scope :pending
  scope :unapproved

  permit_params :name, :slug, :website, :contact_page, :phone, :email,
                :address_1, :address_2, :city, :state, :zip, :lat, :long,
                :opening_date, :featured, :follow_up, :description,
                :hunting_area_size, :terrain,
                :handicap_status, :child_status, :pet_status,
                :status, :author_id, :featured_image, category_ids: [], species_ids: [], weapon_type_ids: []
  index do
    selectable_column
    column :id
    column :author
    column :status
    column :name
    column :city
    column :state
    actions
  end

  filter :author
  filter :name
  filter :state
  filter :categories
  filter :species
  filter :weapon_types
  filter :created_at
  filter :updated_at

  sidebar :categories, only: :show do
    h4 'Categories'
    ul do
      location.categories.each do |category|
        li link_to(category, admin_category_path(category))
      end
    end
    h4 'Species'
    ul do
      location.species.each do |species|
        li link_to(species, admin_species_path(species))
      end
    end
    h4 'Weapon Types'
    ul do
      location.weapon_types.each do |weapon_type|
        li link_to(weapon_type, admin_weapon_type_path(weapon_type))
      end
    end
  end

  show do
    attributes_table do
      row :name
      row :status
      row :slug
      row :featured_image do
        image_tag location.featured_image.url(:medium), class: 'featured-image'
      end
      row :description
      row :created_at
      row :updated_at
      row :slug
      row :author
      row :handicap_status
      row :pet_status
      row :child_status
      row :website
      row :contact_page
      row :phone
      row :email
      row :address_1
      row :address_2
      row :city
      row :state
      row :zip
      row :lat
      row :long
      row :hunting_area_size
      row :terrain
      row :submitter
      row :submitter_notes
    end
    active_admin_comments
  end

  form do |f|
    inputs 'Details' do
      input :name
      input :status, as: :select,
            collection: Location.statuses.keys.map { |key| [key, key]},
            include_blank: false,
            selected: f.object.status || 'approved'
      input :slug
      input :description
      input :featured_image
      input :category_ids, as: :check_boxes, :collection => Category.order('name ASC').all
      input :handicap_status, as: :select,
            collection:  Location.handicap_statuses.keys.map { |key| [(key.to_s[9..-1]).humanize, key]},
            include_blank: false,
            selected: 'handicap_unknown'
      input :pet_status, as: :select,
            collection: Location.pet_statuses.keys.map { |key| [(key.to_s[4..-1]).humanize, key]},
            include_blank: false,
            selected: 'pet_unknown'
      input :child_status, as: :select,
            collection: Location.child_statuses.keys.map { |key| [(key.to_s[(key.index('_')+1)..-1]).humanize, key]},
            include_blank: false,
            selected: 'children_unknown'

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
      input :state, as: :select,
            collection: Location.states,
            prompt: 'Select a State'
      input :zip
      input :lat
      input :long
    end
    inputs 'Terrain & Wildlife' do
      input :hunting_area_size
      input :terrain
    end
    inputs 'Species', class: 'nested_checkboxes' do
      f.input :species_ids, as: :check_boxes, collection: Species.where(parent_id: nil), nested_set: true
    end
    inputs 'Weapon Types' do
      f.input :weapon_type_ids, as: :check_boxes, collection: WeaponType.all
    end
    actions
  end

  controller do
    def create
      @author = current_admin_user
      @location = Location.new(permitted_params[:location])
      @location.author = @author
      if @location.save
        redirect_to admin_location_path(@location), notice: t('flash.actions.create.notice', resource_name: Location.model_name.human)
      else
        render :new
      end
    end
    def find_resource
      Location.friendly.find(params[:id])
    end
  end

  batch_action :approve do |ids|
    Location.where(id: ids).update_all(status: Location.statuses[:approved])
    redirect_to collection_path, alert: 'The locations have been approved.'
  end

  batch_action :unapprove do |ids|
    Location.where(id: ids).update_all(status: Location.statuses[:unapproved])
    redirect_to collection_path, alert: 'The locations have been unapproved.'
  end
end
