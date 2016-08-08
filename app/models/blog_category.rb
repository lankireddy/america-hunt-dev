class BlogCategory < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :posts, through: :blog_category_posts
  validates :name, presence: true

  def to_s
    name
  end
end
