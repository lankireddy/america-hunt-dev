ActiveAdmin.register Category do
  menu parent: 'Locations'

  permit_params :name

  index do
    column :id
    column :parent
    column :name
    actions
  end
end
