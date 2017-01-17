class BlogCategory < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :posts, through: :blog_category_posts

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true

  enum homepage_display: [:not_visible, :name_only, :widget]

  scope :menu, -> { where.not(homepage_display: homepage_displays[:not_visible]) }

  scope :priority_categories, -> { menu.order(:name) }

  HUNTING_AND_SHOOTING_NEWS_TITLE = 'Hunting and Shooting News'
  WILDLIFE_NEWS_TITLE = 'State Wildlife Agency News'
  HUNTING_ORG_TILE = 'Hunting Organizations'
  FIELD_NOTES_FROM_GAME_WARDENS_TITLE = 'The Thin Green Line'

  def to_s
    name
  end

  def self.static_category(name)
    BlogCategory.find_by(name: name)
  end

  # This is so fragile...
  def self.primary_category
    static_category(HUNTING_AND_SHOOTING_NEWS_TITLE) || BlogCategory.menu.first
  end

  def self.wildlife_category
    static_category(WILDLIFE_NEWS_TITLE)
  end

  def self.hunting_org_category
    static_category(HUNTING_ORG_TILE)
  end

  def self.field_notes_from_game_wardens_category
    static_category(FIELD_NOTES_FROM_GAME_WARDENS_TITLE)
  end
end
