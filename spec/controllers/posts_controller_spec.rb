require 'spec_helper'

RSpec.describe PostsController, type: :controller do

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = Fabricate :post
      get :show, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
    it 'assigns the requested post\'s title to @page_title' do
      post = Fabricate :post
      get :show, {:id => post.to_param}
      expect(assigns(:page_title)).to eq(post.title)
    end
  end
end
