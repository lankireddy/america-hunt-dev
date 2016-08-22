$ ->
  $("#new_review").on "ajax:success", (e, data, status, xhr) ->
    $("#reviews").append "<div id=\"review_#{data.id}\" class=\"review panel \">
                          <div class=\"content\">
                          <p class='warning'>This review is private pending review</p>
                          #{data.body}
                          </div>
                          </div>"
    $("#review_body").val('')
    $("#review_star_rating").val('')
  .on "ajax:error", (e, xhr, status, error) ->
    errors = JSON.parse(xhr.responseText)
    $.each errors, ( key, value ) ->
      form_group = $("#review_#{key}").parents('.form-group')
      form_group.addClass('has-error')
      form_group.append($('<span class="help-block small" />').text(value))
