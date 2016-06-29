class UsersController < ApplicationController
  # authenticated!

  def profile
    @user = current_user
  end
end
