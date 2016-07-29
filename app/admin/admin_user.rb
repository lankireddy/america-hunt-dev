ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :name

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs 'Admin Details' do
      f.input :email
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :name
      row :created_at
      row :updated_at
      row :last_sign_in_at
    end
    active_admin_comments
  end

end
