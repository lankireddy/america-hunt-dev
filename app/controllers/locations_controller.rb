class LocationsController < ApplicationController
  DEFAULT_SEARCH_RADIUS = 50
  before_action :set_location, only: [:show]

  # GET /locations
  def index
    @query = params[:query]
    if @query
      @locations = Location.near(@query,DEFAULT_SEARCH_RADIUS)
      @locations = @locations.joins(:location_categories).where(location_categories:{ category_id: params[:category_id] }) if(params[:category_id].present?)
    else
      @locations = []
    end
    @body_classes = 'content-list margin-header'
  end

  # GET /locations/1
  def show
    @query = params[:query]
    @previous_page = request.referer
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
    @body_classes = 'margin-header'

  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :website, :contact_page, :phone, :email,
                                       :address_1, :address_2, :city, :zip, :lat, :long,
                                       :opening_date, :featured, :follow_up, :description,
                                       :handicap_status, :child_status, :pet_status, :state)
    end
end
