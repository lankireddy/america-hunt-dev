describe Page do

  let(:page) { Fabricate :page }

  it 'should have a valid fabricator' do
    expect(Fabricate.build :page).to be_valid
  end

  describe '#to_s' do
    it 'returns the title of the page' do
      expect("#{page}").to eq(page.title)
    end
  end
end
