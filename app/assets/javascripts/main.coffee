ready = ->
  # Google Analytics
  ((i, s, o, g, r, a, m) ->
    i['GoogleAnalyticsObject'] = r
    i[r] = i[r] or ->
      (i[r].q = i[r].q or []).push arguments
      return

    i[r].l = 1 * new Date
    a = s.createElement(o)
    m = s.getElementsByTagName(o)[0]
    a.async = 1
    a.src = g
    m.parentNode.insertBefore a, m
    return
  ) window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga'
  ga 'create', 'UA-84728978-1', 'auto'
  ga 'send', 'pageview'


  # init the animation when scrolling the page
  (new WOW).init()

  $('.scroll').click ->
    $('html, body').animate {
      scrollTop: $('#' + $(this).attr('target')).offset().top - 40
    }, 700
    if $(this).hasClass('xs-menu-link')
      hideMainMenu()
    return false

  $('a#click-web-dev').click ->
    $('a#link-web-dev').click()
    $('a#link-web-dev').addClass('active')

  $('a#click-mob-dev').click ->
    $('a#link-mob-dev').click()
    $('a#link-mob-dev').addClass('active')

  $('a#click-usability').click ->
    $('a#link-usability').click()
    $('a#link-usability').addClass('active')

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


  # Contact Form
  $('#contact-us-screen form a.submit').click ->
    startSending()
    contactForm = $('#contact-us-screen form')
    contactForm.find('input, select, textarea').removeClass('error')
    inputFirstName = contactForm.find('input#client_first_name')
    inputEmail = contactForm.find('input#client_email')
    selectCountry = contactForm.find('select#client_country')
    textareaMessage = contactForm.find('textarea#client_message')

    isError = false
    if inputFirstName.val() == ''
      inputFirstName.addClass('error')
      isError = true
    if inputEmail.val() == ''
      inputEmail.addClass('error')
      isError = true
    if selectCountry.val() == ''
      selectCountry.addClass('error')
      isError = true
    if textareaMessage.val() == ''
      textareaMessage.addClass('error')
      isError = true

    if isError
      stopSending()
    else
      contactForm.submit()
    return false

  $('#contact-us-screen form').on 'submit', (e) ->
    $.ajax
      type: 'POST'
      dataType: 'json'
      url: $(this).attr('action')
      data: $(this).serialize()
      success: (data) ->
        showSuccessMessage('#form-messages', data.message)
        stopSending()
        return false
      error: (data) ->
        showErrorMessage('#form-messages', data.responseJSON.message)
        stopSending()
        return false
    e.preventDefault()

  $('#contact-us-screen form').find('input, select, textarea').on 'change', (e) ->
    if $(this).val() != ''
      $(this).removeClass('error')



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

startSending = ->
  $('#contact-us-screen form a.submit').text('SENDING...')
  $('#contact-us-screen form a.submit').addClass('disabled')

stopSending = ->
  $('#contact-us-screen form a.submit').text('SEND')
  $('#contact-us-screen form a.submit').removeClass('disabled')

showSuccessMessage = (block, message) ->
  $(block).html(successMessage(message))
  $(block).find('.message.success').delay(5000).fadeOut 300, ->
    $(this).remove()
    return false

showErrorMessage = (block, message) ->
  $(block).html(errorMessage(message))
  $(block).find('.message.error').delay(5000).fadeOut 300, ->
    $(this).remove()
    return false

successMessage = (message) ->
  return "<div class='message success'>" + message + "</div>"

errorMessage = (message) ->
  return "<div class='message error'>" + message + "</div>"

# Because of the turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)
