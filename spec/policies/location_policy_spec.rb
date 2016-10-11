describe LocationPolicy do
  let(:user) { Fabricate :user }
  let(:location) { Fabricate :location }

  subject { described_class }

  permissions :show?, :new? do
    it { is_expected.to permit(user, location) }
  end

  permissions :new? do
    it { is_expected.to permit(user) }
  end

  permissions :create? do
    it { is_expected.to permit(user) }
  end
end
