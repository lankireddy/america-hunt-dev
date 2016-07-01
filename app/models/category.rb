class Category < ActiveRecord::Base
  has_many :location_categories
  has_many :locations, through: :location_categories
  belongs_to :parent, class_name: Category

  validates :travelier_id, uniqueness: true

end
