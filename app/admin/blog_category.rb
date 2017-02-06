ActiveAdmin.register BlogCategory do
  menu parent: 'Posts'

  permit_params :name, :homepage_display, :description, :image

  show do
    attributes_table do
      row :name
      row :description
      row :image do
        image_tag blog_category.image.url(:medium), class: 'featured-image'
      end
      row :homepage_display do
        blog_category.homepage_display.humanize
      end
    end
  end

  form do |f|
    inputs do
      input :name
      input :description
      if f.object.image.present?
        input :image, required: false, hint: image_tag(object.image.url(:medium)).html_safe
      else
        input :image
      end
      input :homepage_display, as: :select,
                               collection: BlogCategory.homepage_displays.keys.map { |key| [key.humanize, key] },
                               include_blank: false,
                               selected: f.object.homepage_display
    end
    actions
  end

  controller do
    def find_resource
      BlogCategory.friendly.find(params[:id])
    end
  end
end
