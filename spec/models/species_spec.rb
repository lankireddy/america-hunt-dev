describe Species do
  let!(:species) { Fabricate :species }

  it { is_expected.to have_many :children }
  it { is_expected.to belong_to :parent }


  it 'should have a valid fabricator' do
    expect(Fabricate.build :species).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the species' do
      expect("#{species}").to eq(species.name)
    end
  end

end
