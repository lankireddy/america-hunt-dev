ActiveAdmin.register WeaponType do
  menu parent: 'Locations'

  permit_params :name

  index do
    column :id
    column :name
    actions
  end
end
