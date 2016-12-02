#This is a shim to prevent ordering posts on the 'all' index

module ActiveAdmin
  module Views
    class ReorderableTableFor < IndexAsTable::IndexTableFor
      builder_method :reorderable_table_for

      def build(collection, options = {}, &block)
        options[:class] = [options[:class], 'aa-reorderable'].compact.join(' ')

        super(collection, options) do
          reorder_column unless params['scope'] && params['scope'] == 'all' && params['controller'] == 'admin/posts'
          block.call if block.present?
        end
      end

    end
  end
end
