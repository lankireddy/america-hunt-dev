class Post < ActiveRecord::Base
  extend Enumerize
  extend FriendlyId
  acts_as_list

  TITLE_SHORT_LENGTH=10
  WIDGET_POST_LIMIT = 7

  friendly_id :slug_candidates, use: :slugged

  belongs_to :author, class_name: 'AdminUser'
  has_many :blog_category_posts, dependent: :destroy
  has_many :blog_categories, through: :blog_category_posts

  enumerize :featured_position,
            in: [:not_featured, :primary_featured, :secondary_featured_one, :secondary_featured_two, :secondary_featured_three],
            default: :not_featured,
            scope: true

  has_attached_file :featured_image, styles: { hero: '1366x624>', medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\z/
  validates :title, presence: true

  default_scope { order(position: :asc, created_at: :desc) }

  paginates_per 10

  before_save :ensure_featured_limits, if: :featured_position_changed?

  def slug_candidates
    [:title_short, :title]
  end

  def title_short
    title.try(:truncate_words, TITLE_SHORT_LENGTH)
  end

  def to_s
    title
  end

  def priority_blog_category
    blog_categories.menu.order(:name).first
  end

  def ensure_featured_limits
    return true if featured_position == 'not_featured'

    posts = Post.where(featured_position: featured_position)
    if posts.any?
      posts.update_all(featured_position: :not_featured)
    end

    true
  end

end
