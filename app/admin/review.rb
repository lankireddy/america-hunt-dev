ActiveAdmin.register Review do
  permit_params :status

  actions :all, :except => [:new]

  scope :approved, default: true
  scope :pending
  scope :unapproved

  index do
    id_column
    column :location
    column :star_rating
    column :body
    column :created_at
    actions
  end

  sidebar :review, only: :edit do
    attributes_table_for review do
      row :location
      row :star_rating
      row :body
      row :created_at
    end
  end

  form do |f|
    inputs do
      input :status, as: :select,
            collection: Review.statuses.keys.map { |key| [key, key]},
            include_blank: false,
            selected: f.object.status
    end
    actions
  end
end