class Post < ActiveRecord::Base
  TITLE_SHORT_LENGTH=10

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :author, class_name: 'AdminUser'

  validates :title, presence: true

  def slug_candidates
    [:title_short, :title]
  end

  def title_short
    title.truncate_words(TITLE_SHORT_LENGTH)
  end

  def to_s
    title
  end
end
