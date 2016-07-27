describe Category do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :category).to be_valid
  end
end
