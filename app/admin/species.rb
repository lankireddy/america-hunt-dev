ActiveAdmin.register Species do
  menu parent: 'Locations'

  permit_params :name, :parent_id

  index do
    column :id
    column :parent
    column :name
    actions
  end

  form do |f|
    inputs do
      input :parent_id, as: :select, collection: Species.top_level
      input :name
    end
    actions
  end
end
