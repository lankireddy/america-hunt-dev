describe WeaponType do
  let!(:weapon_type) { Fabricate :weapon_type }

  it { is_expected.to have_many :location_weapon_types }
  it { is_expected.to have_many(:locations).through(:location_weapon_types) }

  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:name) }


  it 'should have a valid fabricator' do
    expect(Fabricate.build :weapon_type).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the weapon_type' do
      expect("#{weapon_type}").to eq(weapon_type.name)
    end
  end
end
