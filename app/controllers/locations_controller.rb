class LocationsController < ApplicationController
  before_action :set_location, only: [:show]
  before_action :set_filter_options, only: [:index, :new]

  # GET /locations
  def index
    @state_alpha2 = params[:state_alpha2]
    @species_ids = params[:species_ids]

    filter_locations

    matching_states = Location.states.select { |state| state[1] == @state_alpha2 }
    if matching_states.present?
      state_name = matching_states.first[0]
      set_state_metas(state_name)
    end

    @location_params = params.except(:page)
    @body_classes = 'content-list margin-header'
  end

  # GET /locations/example-location
  def show
    @state_alpha2 = params[:state_alpha2]
    @previous_page = request.referer || state_locations_path(state_alpha2: @location.state)
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
    @page_url = location_url @location.to_param
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
      # redirect_to @location, notice: 'Location was successfully created.'
    else
      set_filter_options
      render :new
    end
  end

  private

    def set_location
      @location = Location.friendly.find(params[:id])
      redirect_to action: action_name, id: @location.friendly_id, status: 301 unless @location.friendly_id == params[:id]
    end

    def set_filter_options
      @categories = Category.all
      @top_level_species = Species.top_level
      @weapon_types = WeaponType.all
    end

    def set_state_metas(state_name)
      @title = "#{state_name} Hunting Destinations"
      @page_title = 'America Hunt: ' + @title
      @page_description = "Listing of hunting destinations in #{state_name}."
    end

    def filter_locations
      @locations = Location.approved.where(state: @state_alpha2)
      @locations = @locations.joins(:species).where(species: { id: @species_ids }) if @species_ids.present?
      @locations = @locations.order(id: :desc).uniq.page params[:page]
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :website, :phone, :email,
                                       :address_1, :address_2, :city, :zip, :state, :handicap_status,
                                       :hunting_area_size, :terrain, :submitter_notes, :featured_image,
                                       species_ids: [], weapon_type_ids: [], category_ids: [])
    end
end
