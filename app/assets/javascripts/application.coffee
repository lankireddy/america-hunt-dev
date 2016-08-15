#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_directory .

$ ->
  multiselect =  $('.select-multi')
  show_filter = !!multiselect.data('enablefiltering')
  multiselect.multiselect
    nonSelectedText: multiselect.children('option[value=""]').text(),
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