describe AdminUser do

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :name }


  it 'should have a valid fabricator' do
    expect(Fabricate.build :admin_user).to be_valid
  end
end
