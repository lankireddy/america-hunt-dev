describe LocationCategory do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :location_category).to be_valid
  end
end
