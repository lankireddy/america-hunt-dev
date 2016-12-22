
describe 'HomePage' do
  before do
    Fabricate :homepage_video, published: true
  end

  context 'home_page visited' do
    before do
      visit '/browse'
    end

    context 'extra small screen' do
      before do
        page.current_window.resize_to(320, 640)
      end

      it 'should not display video', js: true do
        expect(page).to_not have_selector('video')
      end
    end

    context ' > extra small screen' do
      it 'should display a video' do
        expect(page).to have_selector('video')
      end

      it 'video should be muted' do
        expect(page).to have_selector('video[muted]')
      end
    end
  end

  context 'blog categories' do
    let!(:name_only_categories) { Fabricate.times 5, :blog_category, homepage_display: 'name_only' }
    let!(:widget_categories) { Fabricate.times 2, :blog_category, homepage_display: 'widget' }
    let!(:widget_1_posts) { Fabricate.times 10, :post, blog_categories: [widget_categories.first] }
    let!(:widget_2_posts) { Fabricate.times 10, :post, blog_categories: [widget_categories.second] }

    before do
      visit '/browse'
    end

    it 'displays a link for each name only blog category' do
      name_only_categories.each do |category|
        expect(page).to have_link(category.name, href: blog_category_path(category))
      end
    end

    it 'displays a read more link for each widget blog category' do
      widget_categories.each do |category|
        expect(page).to have_link('Read More ' + category.name, href: blog_category_path(category))
      end
    end

    it 'displays a title for each widget category' do
      widget_categories.each do |category|
        expect(page).to have_selector('h1', text: category.name)
      end
    end

    it 'displays post link for each post in widget category (up to limit)' do
      widget_categories.each do |category|
        category.posts.limit(Post::WIDGET_POST_LIMIT).each do |post|
          expect(page).to have_link(post.title, href: post_path(post))
        end
      end
    end

    it 'displays only max posts for each widget category' do
      expect(page).to have_selector('.post', count: Post::WIDGET_POST_LIMIT * 2)
    end
  end
end
