describe User do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :user).to be_valid
  end
end
