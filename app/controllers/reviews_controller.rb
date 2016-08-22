class ReviewsController < ApplicationController
  before_action :set_location
  # POST /reviews
  def create
    @review = @location.reviews.build(review_params)
    authorize @review
    @review.submitter = current_user
    @review.status = :pending
    respond_to do |format|
      format.json do
        if @review.save
          render json: @review.to_json
        else
          render json: @review.errors.to_json, status: :unprocessable_entity
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_filters
    @categories = Category.all
    @top_level_species = Species.top_level
    @weapon_types = WeaponType.all
  end

  def review_params
    params.require(:review).permit(:star_rating, :body, :location_id)
  end
end

