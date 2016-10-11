describe Review do
  it { is_expected.to belong_to(:submitter) }
  it { is_expected.to belong_to(:location) }

  it 'should have a valid fabricator' do
    expect(Fabricate.build(:review)).to be_valid
  end
end
