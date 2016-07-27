class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable
  # devise :database_authenticatable, :registerable, :timeoutable,
         # :recoverable, :rememberable, :trackable, :validatable,
         # :token_authenticatable
end
