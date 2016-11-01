class LocationsController < ApplicationController
  before_action :set_location, only: [:show]
  before_action :set_filters, only: [:index, :new]

  # GET /locations
  def index
    @state_alpha2 = params[:state_alpha2]
    @species_ids = params[:species_ids]

    @locations = Location.approved.where(state: @state_alpha2)
    @locations = @locations.joins(:species).where(species: { id: @species_ids }) if @species_ids.present?
    @locations = @locations.uniq.page params[:page]

    state_name = Location.states.select { |state| state[1] == @state_alpha2 }.first[0]
    @title = "#{state_name} Hunting Destinations"
    @page_title = 'America Hunt: ' + @title
    @page_description = 'Listing of hunting destinations in #{state_name}.'

    @location_params = params.except(:page)
    @body_classes = 'content-list margin-header'
  end

  # GET /locations/1
  def show
    @state_alpha2 = params[:state_alpha2]
    @previous_page = request.referer || state_locations_path(state_alpha2: @location.state)
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations
  def create
    @location = Location.new(location_params)
    authorize @location
    @location.submitter = current_user
    @location.status = :pending
    if @location.save
      render
      #redirect_to @location, notice: 'Location was successfully created.'
    else
      set_filters
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def set_filters
      @categories = Category.all
      @top_level_species = Species.top_level
      @weapon_types = WeaponType.all
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :website, :phone, :email,
                                       :address_1, :address_2, :city, :zip, :state, :handicap_status,
                                       :hunting_area_size, :terrain, :submitter_notes, :featured_image,
                                       species_ids: [], weapon_type_ids: [], category_ids: []
                                       )
    end
end
