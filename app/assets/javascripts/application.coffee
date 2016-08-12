#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require_directory .

$ ->
  $('.select-multi').multiselect({
    nonSelectedText: $('.select-multi').children('option[value=""]').text(),
    onInitialized: (select, container) ->
      container.find('input[value=""]').parents('li').hide()
  })
