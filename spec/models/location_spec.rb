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

  it 'should have a valid fabricator' do
    expect(Fabricate.build :location).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the location' do
      expect("#{location}").to eq(location.name)
    end
  end

  describe 'excerpt' do
    it 'returns the excerpt length word count' do
      expect(location.excerpt.scan(/\w+/).size).to be <= (Location::EXCERPT_LENGTH)
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
end
