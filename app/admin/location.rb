ActiveAdmin.register Location do

  scope :approved, default: true
  scope :pending
  scope :unapproved

  permit_params :name, :website, :contact_page, :phone, :email,
                :address_1, :address_2, :city, :state, :zip, :lat, :long,
                :opening_date, :featured, :follow_up, :description,
                :hunting_area_size, :terrain,
                :handicap_status, :child_status, :pet_status,
                :status, :author_id, category_ids: [], species_ids: [], weapon_type_ids: []
  index do
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

  form do |f|
    inputs 'Details' do
      input :name
      input :status, as: :select,
            collection: Location.statuses.keys.map { |key| [key, key]},
            include_blank: false,
            selected: f.object.status || 'approved'
      input :description
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
      input :state
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
  end
end
