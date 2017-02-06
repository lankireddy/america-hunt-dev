ActiveAdmin.register Ad do
  scope :all, default: true
  scope :sidebar
  scope :top

  permit_params :name, :image, :url, :slot, :image_file_name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :url
    actions
  end

  form do |_f|
    inputs do
      input :name
      input :image
      input :url
      input :slot, as: :select
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :image do
        image_tag ad.image.url(:medium), class: 'image'
      end
      row :url
      row :slot
      row :created_at
    end
    active_admin_comments
  end
end
