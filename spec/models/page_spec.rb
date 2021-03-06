describe Page do
  let(:page) { Fabricate :page }

  it { is_expected.to have_attached_file(:featured_image) }

  it { is_expected.to validate_presence_of(:title) }

  it 'should have a valid fabricator' do
    expect(Fabricate.build(:page)).to be_valid
  end

  describe '#to_s' do
    it 'returns the title of the page' do
      expect(page.to_s).to eq(page.title)
    end
  end
end
