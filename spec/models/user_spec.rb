describe User do

  it { is_expected.to have_attached_file(:profile_image) }

  it { is_expected.to validate_presence_of(:first_name)}
  it { is_expected.to validate_presence_of(:last_name)}
  it { is_expected.to validate_presence_of(:email)}

  it 'should have a valid fabricator' do
    expect(Fabricate.build :user).to be_valid
  end
end
