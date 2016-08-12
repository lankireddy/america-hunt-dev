describe HomePageController do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all content posts as @content_posts' do
      content_post = Fabricate :content_post
      get :index, {}
      expect(assigns(:content_posts)).to eq([content_post])
    end

    it 'assigns all categories as @categories' do
      category = Fabricate :category
      get :index, {}
      expect(assigns(:categories)).to eq([category])
    end

    it 'assigns top level species as @species' do
      top_level_species = Fabricate.times 2, :species
      other_species = Fabricate.times 2, :species, parent_id: top_level_species[0].id
      get :index, {}
      expect(assigns(:species)).to match_array(top_level_species)
    end
  end
end
