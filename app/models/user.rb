class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable, :recoverable

  validates :first_name, :last_name, presence: true

  def to_s
    [first_name, last_name].join(' ')
  end
end
