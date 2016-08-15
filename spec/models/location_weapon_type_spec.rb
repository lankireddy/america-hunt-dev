describe LocationWeaponType do
  it { is_expected.to belong_to :location  }
  it { is_expected.to belong_to :weapon_type }
end
