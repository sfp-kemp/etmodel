$(document).ready ->
  # New scenario popup
  # ------------------

  $('#start-scenario .choice').click (event) ->
    $('#scenario-launcher').hide()
    $('#new-scenario-form').show()

    event.preventDefault()

  $('#new-scenario-form .commit a').click (event) ->
    $('#scenario-launcher').show()
    $('#new-scenario-form').hide()

    event.preventDefault()

  $('.video-intro .video').magnificPopup
    disableOn: 700
    type: 'iframe'
    mainClass: 'mfp-fade'
    removalDelay: 160
    preloader: false,
    fixedContentPos: false

  # Year selection
  # --------------

  yearWrap   = $('#new-scenario-form .year')
  yearList   = yearWrap.find('ol')
  yearSelect = $('#end_year')

  yearList.find('li[data-year]').click (event) ->
    selectedYear = $(event.target).data('year')

    yearList
      .removeClass('sel-2020')
      .removeClass('sel-2030')
      .removeClass('sel-2040')
      .removeClass('sel-2050')
      .addClass("sel-#{ selectedYear }")

    yearSelect.val(selectedYear)

  yearList.addClass("sel-#{ yearSelect.val() }")

  if parseInt(yearSelect.val(), 10) % 10
    yearWrap.find('.custom').show()
    yearList.hide()

  yearWrap.find('.select-custom a').click (event) ->
    yearWrap.find('.common').slideUp()
    yearWrap.find('.custom').slideDown()

    event.preventDefault()

  # Region selection
  # ----------------

  regionList = $('#new-scenario-form .region ul')
  regionOpts = regionList.find('li')

  regionField = $('#new-scenario-form input[name=area_code]')

  regionOpts.click (event) ->
    $target = $(event.currentTarget)

    regionOpts.removeClass('active')

    $target.addClass('active')
    regionField.val($target.data('region'))

  $("#new-scenario-form .region li.#{ regionField.val() }").addClass('active')
