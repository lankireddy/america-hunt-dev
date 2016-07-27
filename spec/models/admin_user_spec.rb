describe AdminUser do
  it 'should have a valid fabricator' do
    expect(Fabricate.build :admin_user).to be_valid
  end
end
