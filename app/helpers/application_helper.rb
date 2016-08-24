module ApplicationHelper
  def link_to_active_class(name, options = {}, html_options = {}, &block)
    html_options[:class] = html_options[:class].to_s + 'active' if current_page?(options.to_s)
    link_to name, options, html_options, &block
  end
end
