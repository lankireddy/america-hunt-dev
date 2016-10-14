ActiveAdmin.register BlogCategory do
  menu parent: 'Posts'

  permit_params :name, :homepage_display

  form do |f|
    inputs do
      input :name
      input :homepage_display, as: :select,
            collection: BlogCategory.homepage_displays.keys.map  { |key| [key.humanize, key]},
            include_blank: false,
            selected: f.object.homepage_display
    end
    actions
  end

end
