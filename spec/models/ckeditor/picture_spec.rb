describe Ckeditor::Picture do
  let!(:picture) { Fabricate :ckeditor_picture }

  it { is_expected.to have_attached_file(:data) }
  it { is_expected.to validate_attachment_presence(:data) }

  describe 'url_content' do
    it 'returns the url for the content size version of the picture' do
      expect(picture.url_content).to eq picture.url(:content)
    end
  end
end
