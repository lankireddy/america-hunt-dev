describe Category do
  let!(:category) { Fabricate :category }

  it { is_expected.to have_many :location_categories }
  it { is_expected.to have_many(:locations).through(:location_categories) }

  it 'should have a valid fabricator' do
    expect(Fabricate.build :category).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the category' do
      expect("#{category}").to eq(category.name)
    end
  end
end
