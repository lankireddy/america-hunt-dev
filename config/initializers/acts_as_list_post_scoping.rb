#Monkeypatch to force Posts to only look at their priority category when scoping
module ActiveRecord
  module Acts
    module List
      module InstanceMethods

        private

          def acts_as_list_list
            if self.class == Post && self.priority_blog_category.present?
              Post.unscoped do
                Post.joins(:blog_category_posts).where(blog_category_posts: { blog_category_id: self.priority_blog_category.id })
              end
            else
              acts_as_list_class.unscoped do
                acts_as_list_class.where(scope_condition)
              end
            end
          end

      end
    end
  end
end
