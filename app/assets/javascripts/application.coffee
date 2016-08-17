#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_directory .

$ ->
  multiselect =  $('.select-multi')
  multiselect.each ->
    current_select = $(this)
    show_filter = !!current_select.data('enablefiltering')
    current_select.multiselect
      nonSelectedText: current_select.children('option[value=""]').text(),
      enableCollapsibleOptGroups: true,
      enableFiltering: show_filter,
      enableCaseInsensitiveFiltering: show_filter,
      onDropdownShown: (event) ->
        $('.caret-container').click()
      , onInitialized: (select, container) ->
        container.find('input[value=""]').parents('li').remove()
      , onChange: (option) ->
        query = $('.multiselect-container li.multiselect-filter input').val()
        $('.multiselect-container li.multiselect-filter input').val('').trigger('keydown') if query?