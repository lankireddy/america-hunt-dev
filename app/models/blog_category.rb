class BlogCategory < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :posts, through: :blog_category_posts

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true

  enum homepage_display: [:not_visible, :name_only, :widget]

  scope :menu, -> { where.not(homepage_display: homepage_displays[:not_visible]) }

  scope :priority_categories, -> { menu.order(:name) }

  def to_s
    name
  end

  # This is so fragile...
  def self.primary_category
    BlogCategory.where(name: 'Hunting and Shooting News').first || BlogCategory.menu.first
  end

  def self.wildlife_category
    BlogCategory.where(name: 'State Wildlife Agency News').first
  end

  def self.hunting_org_category
    BlogCategory.where(name: 'Hunting Organizations').first
  end

  def self.field_notes_from_game_wardens_category
    BlogCategory.where(name: 'The Thin Green Line').first
  end
end
