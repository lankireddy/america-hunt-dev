describe Location do
  let!(:location) { Fabricate :location }
  it { is_expected.to have_many :location_categories }
  it { is_expected.to have_many(:categories).through(:location_categories) }
  it { is_expected.to have_many :location_species }
  it { is_expected.to have_many(:species).through(:location_species) }

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
  end

  describe '#geocode_street_address' do
    it 'returns a string for geocoding' do
      expect(location.geocode_street_address).to eq("#{location.address_1}, #{location.city}, #{location.state}")
    end
  end
end
