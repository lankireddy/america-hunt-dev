describe Ckeditor::AttachmentFile do
  let!(:attachment_file) { Fabricate :ckeditor_attachment_file }

  it { is_expected.to have_attached_file(:data) }
  it { is_expected.to validate_attachment_presence(:data) }

  describe 'url_thumb' do
    it 'returns the url for the thumbnail version of the attachment' do
      expect(attachment_file.url_thumb).to eq Ckeditor::Utils.filethumb(attachment_file.filename)
    end
  end
end
