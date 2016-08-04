describe Page do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :page).to be_valid
  end
end
