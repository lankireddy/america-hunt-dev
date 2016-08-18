class LocationsController < ApplicationController
  DEFAULT_SEARCH_RADIUS = 50
  before_action :set_location, only: [:show]
  before_action :set_filters, only: [:index, :new]

  # GET /locations
  def index
    @query = params[:query]
    @category_id = params[:category_id]
    @top_level_species_ids = params[:top_level_species_ids]
    @species_ids = params[:species_ids]
    @weapon_type_id = params[:weapon_type_id]

    if @query
      @locations = Location.approved.near(@query,DEFAULT_SEARCH_RADIUS)
      @locations = @locations.joins(:location_categories).where(location_categories:{ category_id: @category_id }) if(@category_id.present?)
      @locations = @locations.joins(:location_weapon_types).where(location_weapon_types: { weapon_type_id: @weapon_type_id}) if(@weapon_type_id.present?)
      @locations = @locations.joins(:species).where(species: { parent_id: @top_level_species_ids}) if(@top_level_species_ids.present?)
      @locations = @locations.joins(:species).where(species: { id: @species_ids}) if(@species_ids.present?)
      @locations = @locations.uniq
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
                                       :hunting_area_size, :terrain, :submitter_notes,
                                       species_ids: [], weapon_type_ids: [], category_ids: []
                                       )
    end
end
