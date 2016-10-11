describe AdminUser do
  let(:admin_user) { Fabricate :admin_user }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :name }

  it 'should have a valid fabricator' do
    expect(Fabricate.build(:admin_user)).to be_valid
  end

  describe '#to_s' do
    it 'returns the email of the admin_user' do
      expect(admin_user.to_s).to eq(admin_user.email)
    end
  end
end
