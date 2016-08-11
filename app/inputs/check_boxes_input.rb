# mostly derived from: https://gist.github.com/michelson/2314495
class CheckBoxesInput < Formtastic::Inputs::CheckBoxesInput

  def to_html
    unless options[:nested_set]
      super
    else
      nested_wrapping(options)
    end
  end

  def nested_wrapping(options)
    choices_wrapping do
      legend_html <<
          hidden_field_for_all <<
          choices_group_wrapping do
            html_template_for_nested_set(options)
          end
    end
  end

  def html_template_for_nested_set(options)
    options[:collection].map{|menu|
      html_for_nested(menu)
    }.join("\n").html_safe
  end

  def html_for_nested(menu, from_nested=false)
    choice = [menu.name , menu.id]
    first_wrap = choice_wrapping(choice_wrapping_html_options(choice)) do
      nested = from_nested ? "" : sub_children(menu)
      choice_html(choice) << nested
    end
  end

  def sub_children(menu)
    template.content_tag( :ul,
                          menu.children.collect do |child|
                            html_for_nested(child, true)
                          end.join("\n").html_safe,
                          {:style=>"margin-left:20px", :class=>"sub_item-#{menu.id} sub-item"}
    )  if menu.children.present?
  end

end