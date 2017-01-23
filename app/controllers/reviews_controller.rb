# Review list for after first 10, create endpoint for json
class ReviewsController < ApplicationController
  before_action :set_location

  def index
    @page_title = "America Hunt: #{@location.name} reviews"
    @reviews = @location.reviews.approved.page params[:page]
  end

  # POST /location/example-location/reviews
  def create
    build_review
    respond_to do |format|
      format.json do
        if @review.save
          render json: @review.to_json(include: :submitter)
        else
          render json: @review.errors.to_json, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def build_review
    @review = @location.reviews.build(review_params)
    authorize @review
    @review.submitter = current_user
    @review.status = :pending
  end

  def set_location
    @location = Location.friendly.find(params[:location_id])
  end

  def review_params
    params.require(:review).permit(:star_rating, :body, :location_id)
  end
end
