module ApplicationHelper
  def li_link_to_active_class(name, options = {}, html_options = {})
    html_options[:class] =  (html_options[:class] || []) << 'active' if current_page?(options.to_s)
    content_tag(:li, link_to(name, options), class: html_options[:class])
  end

  def li_dropdown_link_to_active_class(name, pages = {}, html_options = {})
    html_options[:class] = (html_options[:class] || []) << 'dropdown'
    html_options[:class] << 'active' if active_dropdown(pages)
    content_tag(:li, a_dropdown(name) + ul_dropdown(pages), class: html_options[:class])
  end

  def ul_dropdown(pages = {})
    content_tag :ul, class: 'dropdown-menu' do
      pages.collect { |page| concat(content_tag(:li, link_to(page[:title], page[:path]))) }
    end
  end

  def a_dropdown(name)
    link_to '#', class: 'dropdown-toggle', data: { toggle: 'dropdown' }, role: 'button', aria: { haspopup: 'true', expanded: 'false' } do
      concat name
      concat ' '
      concat tag(:span, class: :caret)
    end
  end

  def active_dropdown(pages)
    pages.any? { |page| current_page?(page[:path]) }
  end
end
