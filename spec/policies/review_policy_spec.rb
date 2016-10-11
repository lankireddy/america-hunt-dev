describe ReviewPolicy do
  let(:user) { Fabricate :user }

  subject { described_class }

  permissions :create? do
    it { is_expected.to permit(user) }
  end
end
