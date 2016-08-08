class BlogCategoryPost < ActiveRecord::Base
  belongs_to :post
  belongs_to :blog_category
end
