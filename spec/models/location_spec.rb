describe Location do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :location).to be_valid
  end
end
