
describe 'HomePage' do

  before do
    Fabricate :homepage_video, published: true
  end

  context 'home_page visited' do
    before do
      visit '/'
    end

    context 'extra small screen' do
      before do
        page.current_window.resize_to(320,640)
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
end
