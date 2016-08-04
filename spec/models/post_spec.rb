describe Post do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :post).to be_valid
  end
end
