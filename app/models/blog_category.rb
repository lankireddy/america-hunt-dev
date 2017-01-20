class BlogCategory < ActiveRecord::Base
  has_many :blog_category_posts, dependent: :destroy
  has_many :posts, through: :blog_category_posts

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true

  enum homepage_display: [:not_visible, :name_only, :widget]

  scope :menu, -> { where.not(homepage_display: homepage_displays[:not_visible]) }

  scope :priority_categories, -> { menu.order(:name) }

  attr_accessor :description, :image

  STATIC_CATEGORIES = [:primary, :wildlife, :hunting_org, :field_notes_from_game_wardens]

  def to_s
    name
  end

  class << self
    STATIC_CATEGORIES.each do |method|
      define_method "#{method}_category" do
        scope = [:categories, method]
        category = BlogCategory.find_by(name: I18n.t(:name, scope: scope))
        category.description = I18n.t(:description, scope: scope)
        category.image = I18n.t(:image, scope: scope)
        category
      end
    end
  end
end
