require 'spec_helper'

RSpec.describe PagesController, type: :controller do

  let(:valid_attributes) { (Fabricate.build :page).attributes }

  describe 'GET #show' do
    it 'assigns the requested page as @page' do
      page = Page.create! valid_attributes
      get :show, {:id => page.to_param}
      expect(assigns(:page)).to eq(page)
    end

    it 'assigns the requested page\'s title to @page_title' do
      page = Page.create! valid_attributes
      get :show, {:id => page.to_param}
      expect(assigns(:page_title)).to eq(page.title)
    end
  end
end
