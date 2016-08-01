describe Location do
  let!(:location) { Fabricate :location }
  it { is_expected.to have_many :location_categories }
  it { is_expected.to have_many(:categories).through(:location_categories) }

  it 'should have a valid fabricator' do
    expect(Fabricate.build :location).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the location' do
      expect("#{location}").to eq(location.name)
    end
  end
end
