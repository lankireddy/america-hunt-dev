class PagesController < ApplicationController
  before_action :set_page, only: :show

  def show
    @page_title = 'America Hunt: ' + @page.title
  end

  private

    def set_page
      @page = Page.friendly.find(params[:id])
    end
end
