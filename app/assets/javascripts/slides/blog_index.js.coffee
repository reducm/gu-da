$(document).ready(->
  startSlide = 1
  if(window.location.hash)
    startSlide = window.location.hash.replace('#','')

    $('#slides').slides({
      preload: true,
    #preloadImage: 'img/loading.gif',
      generatePagination: false,
      play: 1115000,
      pause: 2500,
      pagination:false,
      hoverPause: true,
      start: startSlide,
      animationComplete: ((current) ->
        window.location.hash = '#' + current
        $('.caption').animate({
          bottom:0
        },200))

      #animationStart:((current)->
        #$('.caption').animate({
          #bottom:-35
        #},100)),

      #slidesLoaded: ()->
        #$('.caption').animate({
          #bottom:0
        #},200)
    })
)



