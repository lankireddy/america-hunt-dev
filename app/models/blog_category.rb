class BlogCategory < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :posts, through: :blog_category_posts

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :image, styles: { medium: '200x150>', thumb: '100x75>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :name, presence: true

  enum homepage_display: [:not_visible, :name_only, :widget, :secondary_featured, :under_widget_text_link]

  scope :menu, -> { where.not(homepage_display: homepage_displays[:not_visible]) }

  scope :priority_categories, -> { menu.order(:name) }

  attr_accessor :featured_ids

  def after_initialize
    self.featured_ids = []
  end

  def not_already_used
    posts.where.not(id: featured_ids)
  end

  def featured_post(key)
    featured_post = posts.with_featured_position(key).first || not_already_used.order(:position).limit(1).first
    featured_ids << featured_post.id if featured_post
    featured_post
  end

  def to_s
    name
  end
end
