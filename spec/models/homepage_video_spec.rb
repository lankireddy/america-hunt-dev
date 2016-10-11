describe HomepageVideo do
  let(:homepage_video) { Fabricate :homepage_video }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_attached_file(:video) }
  it { is_expected.to validate_attachment_presence :video }


  it 'should have a valid fabricator' do
    expect(Fabricate.build(:homepage_video)).to be_valid
  end
end
