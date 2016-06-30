class ScrapeCategoriesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    a = Mechanize.new
    TravelierSession.new.login(a)
    a.get('https://portal.travelier.com/admin/categories') do |page|
      top_level_categories = page.search('#category-list > ol li')
      import_categories(top_level_categories)
    end
  end

  def import_categories(cats, parent_id = nil)
    cats.each do |trav_category|
      category = Category.new
      category.travelier_id = trav_category['id'][9..-1]
      category.name = trav_category.at_css('a[href="#"]').text
      category.parent_id = parent_id if parent_id.present?
      category.save
      puts category if category.persisted?
      child_categories = trav_category.css('ol li')
      import_categories(child_categories, category.id)
    end
  end
end
