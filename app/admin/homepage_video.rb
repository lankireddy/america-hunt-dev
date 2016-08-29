ActiveAdmin.register HomepageVideo do

  scope :published, default: true
  scope :unpublished

  permit_params :name, :order, :published, :video, :video_file_name

  index do
    column :id
    column :name
    column :video_file_name
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs do
      input :name
      input :order
      input :published
      input :video
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :video do
        video_tag homepage_video.video.url, class: 'video'
      end
      row :order
      row :created_at
      row :published
    end
    active_admin_comments
  end
end
