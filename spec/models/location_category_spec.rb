describe LocationCategory do
  it { is_expected.to belong_to :location }
  it { is_expected.to belong_to :category }

  it 'should have a valid fabricator' do
    expect(Fabricate.build(:location_category)).to be_valid
  end
end
