$ ->
  resetReviewForm = ->
    $("#review_body").val('')
    $("#review_star_rating").val('').rating('reset')
  buildCreatedReview = (data) ->
    $("#reviews").append "<div id=\"review_#{data.id}\" class=\"review panel \">
                          <div class=\"panel-heading\">
                          <h3 class=\"inline-block h4\">#{data.submitter.first_name} #{data.submitter.last_name}</h3>
                          <time class=\"pull-right\">Now</time>
                          <input class=\"rating\" value='#{data.star_rating}' data-display-only='true' data-container-class='hide-empty-stars rating-info' />
                          </div>
                          <div class=\"panel-body\">
                          <p class='text-warning'>This review is private pending review</p>
                          <p>#{data.body}</p>
                          </div>
                          </div>"
    $("#review_#{data.id} .rating").rating({displayOnly: true, size: 'xxs'})
  displayErrors = (errors) ->
    $.each errors, (key, value) ->
      form_group = $("#review_#{key}").parents('.form-group')
      form_group.addClass('has-error')
      form_group.append($('<span class="help-block small" />').text(value))
  $("#new_review").on "ajax:success", (e, data, status, xhr) ->
    buildCreatedReview(data)
    resetReviewForm()
  .on "ajax:error", (e, xhr, status, error) ->
    errors = JSON.parse(xhr.responseText)
    displayErrors(errors)
