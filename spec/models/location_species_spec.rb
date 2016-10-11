describe LocationSpecies do
  it { is_expected.to belong_to :location }
  it { is_expected.to belong_to :species }
end
