describe Post do
  let!(:post) { Fabricate :post }

  it 'should have a valid fabricator' do
    expect(Fabricate.build :post).to be_valid
  end

  describe '#title_short' do
    it 'returns shorter title' do
      expect(post.title_short.scan(/\w+/).size).to  be <= Post::TITLE_SHORT_LENGTH
    end
  end

  describe '#to_s' do
    it 'returns the title of the post' do
      expect("#{post}").to eq(post.title)
    end
  end
end
