describe Review do
  it { is_expected.to belong_to(:submitter) }
  it { is_expected.to belong_to(:location) }
end
