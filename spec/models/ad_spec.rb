describe Ad do

  let(:ad) { Fabricate :ad }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_attachment_presence :image }

  it { is_expected.to have_attached_file(:image) }

  it 'should have a valid fabricator' do
    expect(Fabricate.build :ad).to be_valid
  end
end
