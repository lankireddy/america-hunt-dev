ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :address_1, :city, :state, :zip, :phone

  actions :all, :except => [:new]

  index do
    column :id
    column :first_name
    column :last_name
    column :created_at
    column :updated_at
    column :email
    actions
  end

  form do |f|
    inputs 'Contact Info' do
      input :email
      input :first_name
      input :last_name
      input :address_1
      input :city
      input :state
      input :zip
      input :phone
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :address_1
      row :city
      row :state
      row :zip
      row :phone
      row :created_at
      row :updated_at
      row :last_sign_in_at
    end
    active_admin_comments
  end
end
