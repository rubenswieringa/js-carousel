
class @Carousel
  DEFAULT_INTERVAL = 3000

  constructor: ( @element, options={} ) ->
    return unless @element?.length
    @currentIndex = 0

    @slideSelector = options.slideSelector || '>img'
    @slides = @element.find "#{@slideSelector}"
    @slides.filter( ':not(:first)' ).remove()

    nextButton = options.next || @element.find 'a.next'
    prevButton = options.prev || @element.find 'a.prev'
    nextButton.click @next
    prevButton.click @prev

    auto = if options.auto == true then Carousel.DEFAULT_INTERVAL else options.auto
    @interval = setInterval @next, auto if auto

  next: =>
    @currentIndex++
    @currentIndex = 0 unless @currentIndex < @slides.length
    slide = @getSlide @currentIndex
    @setSlidePosition slide, '100%' if Modernizr.csstransitions
    @add slide
    return false

  prev: =>
    @currentIndex--
    @currentIndex = @slides.length-1 unless @currentIndex >= 0
    slide = @getSlide @currentIndex
    @setSlidePosition slide, '-100%' if Modernizr.csstransitions
    @add slide
    return false

  add: ( slide ) =>
    lastSlide = @element.find "#{@slideSelector}:last"
    lastSlide.after slide
    duration = @getTransitionDuration slide

    if duration
      setTimeout @setSlidePosition, 0, slide, 0
      setTimeout @clean, duration, slide
    else
      @setSlidePosition slide, 0
      @clean slide

  clean: ( slide ) =>
    slide.prevAll().remove()

  getSlide: ( index ) =>
    slide = $ @slides.get index
    slide = slide.clone() if jQuery.contains document.documentElement, slide.get 0
    slide

  setSlidePosition: ( slide, position ) =>
    slide.css left: position

  getTransitionDuration: ( element ) =>
    return 0 unless Modernizr.csstransitions

    for prefix in Modernizr._prefixes
      duration = element.css "#{ prefix }transition-duration"
      return parseFloat( duration ) * 1000 if duration

    return 0
