class CategoriesController < InheritedResources::Base

  private

    def category_params
      params.require(:category).permit(:name, :travelier_id)
    end
end

