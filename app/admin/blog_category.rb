ActiveAdmin.register BlogCategory do
  menu parent: 'Posts'

  permit_params :name, :homepage_display, :layout

end