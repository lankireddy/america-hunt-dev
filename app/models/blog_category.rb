class BlogCategory < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :posts, through: :blog_category_posts

  validates :name, presence: true

  enum homepage_display: [:not_visible, :name_only, :widget]

  def to_s
    name
  end
end
