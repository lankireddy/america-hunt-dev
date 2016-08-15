ActiveAdmin.register WeaponType do
  permit_params :name
  index do
    column :id
    column :name
    actions
  end
end
