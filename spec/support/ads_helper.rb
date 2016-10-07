module AdsHelper
  shared_context 'ad_page' do
    before do
      @top_ad = Fabricate :ad, slot: 'top'
      sidebar_ads = Fabricate.times 3, :ad, slot: 'sidebar'
      @sidebar_ads = Ad.where(id: sidebar_ads.map(&:id))
    end
  end
end
