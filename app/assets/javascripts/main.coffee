ready = ->
  $('span.earth-globe-container a[rel~=popover]').popover({
    html: true,
    placement: 'bottom',
    trigger: 'focus',
    content: earthGlobeContent()
  })

  $('span.earth-globe-container a[rel~=popover]').on 'show.bs.popover', ->
    $(this).toggleClass('active')

  $('span.earth-globe-container a[rel~=popover]').on 'hide.bs.popover', ->
    $(this).toggleClass('active')

earthGlobeContent = ->
  # return 'sssss'
  return $('span.earth-globe-container a[rel~=popover]').parent().find('.earth-globe-popover-content').html()

# Because of the turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
