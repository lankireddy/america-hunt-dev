ActiveAdmin.register Location do
  permit_params :name, :website, :contact_page, :phone, :email,
                :address_1, :address_2, :city, :zip, :lat, :long,
                :opening_date, :featured, :follow_up, :description,
                :handicap_status, :child_status, :pet_status, :state, :status, :author_id
  index do
    column :id
    column :author
    column :status
    column :name
    column :city
    column :state
    actions
  end
end
