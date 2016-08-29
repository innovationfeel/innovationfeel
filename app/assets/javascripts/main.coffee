ready = ->
  $('span.earth-globe-container a[rel~=popover]').popover({
    html: true,
    placement: 'bottom',
    trigger: 'click',
    content: earthGlobeContent()
  }).on('show.bs.popover', (e) ->
    $(this).addClass('active')
  ).on 'hide.bs.popover', (e) ->
    $(this).removeClass('active')

  # hide popovers on outside click
  $(document).on 'click', (e) ->
    $('a[rel~=popover]').each ->
      if $(this).has(e.target).length == 0 && $('.popover').has(e.target).length == 0
        $(this).not(e.target).popover('hide')
        $('.popover').remove()

earthGlobeContent = ->
  return $('span.earth-globe-container a[rel~=popover]').parent().find('.earth-globe-popover-content').html()

# Because of the turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
