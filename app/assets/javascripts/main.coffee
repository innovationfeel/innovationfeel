ready = ->
  # init the animation when scrolling the page
  (new WOW).init()

  $('.scroll').click ->
    $('html, body').animate {
      scrollTop: $('#' + $(this).attr('target')).offset().top - 40
    }, 700
    if $(this).hasClass('xs-menu-link')
      hideMainMenu()
    return false

  if !isMobile()
    $('#what-we-do-screen .container.data .images a').first().addClass('active')

  $('#what-we-do-screen .container.data .images a').click ->
    if isMobile()
      # XS-...
      $(this).toggleClass('active')
      $(this).parent().find('.text-block').slideToggle()
    else
      # Others sizes...
      if !$(this).hasClass('active')
        $(this).parent().parent().find('a').removeClass('active')
        $(this).addClass('active')
        info_block = $(this).parent().parent().parent().find('.info')
        target = $(this).attr('target')
        info_block.find('.text-block').removeClass('bounceOutRight').addClass('bounceOutRight')
        setTimeout (->
          info_block.find('.text-block').removeClass('active').removeClass('bounceOutRight')
          info_block.find('#' + target).addClass('active').addClass('bounceInLeft')
          return false
        ), 400
    return false

  $('#header .earth-globe-xs').on 'click', ->
    $(this).find('span').toggleClass('active')
    hideMainMenu()
    toggleMenu('#header .xs-lang-menu')
    return false

  $('#header .nav-toggle').on 'click', ->
    $(this).toggleClass('on')
    toggleMenu('#header .xs-main-menu')
    hideLangMenu()
    return false

  $('span.earth-globe-container a[rel~=popover]').popover({
    html: true,
    placement: 'bottom',
    trigger: 'manual',
    content: earthGlobeContent()
  }).on('click', (e) ->
    $(this).popover('toggle')
    e.preventDefault()
  ).on('show.bs.popover', (e) ->
    $(this).find('span').addClass('active')
  ).on 'hide.bs.popover', (e) ->
    $(this).find('span').removeClass('active')

  # hide popovers on outside click
  $(document).on 'click', (e) ->
    $('a[rel~=popover]').each ->
      if $(this).has(e.target).length == 0 && $('.popover').has(e.target).length == 0
        $(this).not(e.target).popover('hide')
        $('.popover').remove()


isMobile = ->
  # XS-...
  return $(window).width() < 768

earthGlobeContent = ->
  return $('span.earth-globe-container a[rel~=popover]').parent().find('.earth-globe-popover-content').html()

toggleMenu = (menu) ->
  currentMarginRight = $(menu).css('margin-right')
  console.log(currentMarginRight)
  if currentMarginRight == '0px'
    newMarginRight = '-100%'
  else
    newMarginRight = '0'
  $(menu).animate({'margin-right': newMarginRight})

hideMainMenu = ->
  $('#header .nav-toggle').removeClass('on')
  $('#header .xs-main-menu').animate({'margin-right': '-100%'})

hideLangMenu = ->
  $('#header .earth-globe-xs span').removeClass('active')
  $('#header .xs-lang-menu').animate({'margin-right': '-100%'})

# Because of the turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
