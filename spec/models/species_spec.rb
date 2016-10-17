describe Species do
  let!(:species) { Fabricate :species }

  it { is_expected.to have_many :children }
  it { is_expected.to belong_to :parent }
  it { is_expected.to have_many :location_species }
  it { is_expected.to have_many(:locations).through(:location_species) }

  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:name) }

  it 'should have valid fabricators' do
    expect(Fabricate.build(:species)).to be_valid
    expect(Fabricate.build(:top_level_species)).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the species' do
      expect(species.to_s).to eq(species.name)
    end
  end
end
