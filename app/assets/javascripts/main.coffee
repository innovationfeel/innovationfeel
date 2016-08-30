ready = ->
  $('span.earth-globe-container a[rel~=popover]').popover({
    html: true,
    placement: 'bottom',
    trigger: 'manual',
    content: earthGlobeContent()
  }).on('click', (e) ->
    $(this).popover('toggle')
    e.preventDefault()
  ).on('show.bs.popover', (e) ->
    $(this).addClass('active')
  ).on 'hide.bs.popover', (e) ->
    $(this).removeClass('active')

  # hide popovers on outside click
  $(document).on 'click', (e) ->
    $('a[rel~=popover]').each ->
      if $(this).has(e.target).length == 0 && $('.popover').has(e.target).length == 0
        $(this).not(e.target).popover('hide')
        $('.popover').remove()

  $('.who-we-are-screen .text-block a.more').on 'click', ->
    $('.who-we-are-screen .text-block').toggleClass('more')
    return false
  

earthGlobeContent = ->
  return $('span.earth-globe-container a[rel~=popover]').parent().find('.earth-globe-popover-content').html()

# Because of the turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
