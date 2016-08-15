#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_directory .

$ ->
  $('.select-multi').multiselect
    nonSelectedText: $('.select-multi').children('option[value=""]').text(),
    enableCollapsibleOptGroups: true,
    enableFiltering: $('.select-multi').data('enablefiltering'),
    enableCaseInsensitiveFiltering: true,
    onDropdownShown: (event) ->
      $('.caret-container').click()
    , onInitialized: (select, container) ->
      container.find('input[value=""]').parents('li').remove()
    , onChange: (option) ->
      query = $('.multiselect-container li.multiselect-filter input').val()
      $('.multiselect-container li.multiselect-filter input').val('').trigger('keydown') if query?