describe Location do
  let!(:location) { Fabricate :location }
  it { is_expected.to have_many :location_categories }
  it { is_expected.to have_many(:categories).through(:location_categories) }
  it { is_expected.to have_many :location_species }
  it { is_expected.to have_many(:species).through(:location_species) }
  it { is_expected.to have_many :location_weapon_types }
  it { is_expected.to have_many(:weapon_types).through(:location_weapon_types) }
  it { is_expected.to have_many(:reviews) }
  it { is_expected.to belong_to(:author) }
  it { is_expected.to belong_to(:submitter) }
  it { is_expected.to have_attached_file(:featured_image) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:zip) }

  it 'should have a valid fabricator' do
    expect(Fabricate.build(:location)).to be_valid
  end

  it 'should generate a slug on save' do
    location = Fabricate.build(:location)
    location.save
    expect(location.reload.slug).to_not be_nil
  end

  it 'should generate new slug when slug is set to nil' do
    location = Fabricate.build(:location)
    location.slug = 'custom-slug'
    location.save

    expect(location.reload.slug).to eq 'custom-slug'

    location.slug = nil
    location.save

    expect(location.reload.slug).to_not be_nil
    expect(location.slug).to_not eq 'custom-slug'
  end

  describe '#to_s' do
    it 'returns the name of the location' do
      expect(location.to_s).to eq(location.name)
    end
  end

  describe 'excerpt' do
    it 'returns the excerpt length word count' do
      expect(location.excerpt.scan(/\w+/).size).to be <= Location::EXCERPT_LENGTH
    end

    it 'returns nil when there is no description' do
      location_without_description = Fabricate.build :location, description: nil
      expect(location_without_description.excerpt).to be_nil
    end
  end

  describe '#geocode_street_address' do
    it 'returns a string for geocoding' do
      expect(location.geocode_street_address).to eq("#{location.address_1}, #{location.city}, #{location.state}")
    end
  end

  describe 'self.states' do
    it 'returns 50 items' do
      expect(Location.states.count).to eq 50
    end
  end
end
