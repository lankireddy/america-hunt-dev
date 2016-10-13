class Post < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :blog_categories, through: :blog_category_posts
  has_attached_file :featured_image, styles: { hero: '1366x624>', medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\z/


  TITLE_SHORT_LENGTH=10
  WIDGET_POST_LIMIT = 7


  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  acts_as_list

  belongs_to :author, class_name: 'AdminUser'

  validates :title, presence: true

  default_scope { order(position: :asc, created_at: :desc) }

  scope :content_posts, -> { where.not(body: '') }
  scope :link_posts, -> { where(body: '') }

  paginates_per 10

  def slug_candidates
    [:title_short, :title]
  end

  def title_short
    title.try(:truncate_words, TITLE_SHORT_LENGTH)
  end

  def to_s
    title
  end
end
