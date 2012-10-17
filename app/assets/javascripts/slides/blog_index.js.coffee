$(document).ready(->
  $(".rslides").responsiveSlides({
    auto:true,
    speed: 1000,
    timeout: 4000,
    pager: false,
    nav: true,
    random: false,
    pause: false,
    pauseControls: true,
    #prevText: "Previous",
    #nextText: "Next",
    #maxwidth: "",
    #controls: "",
    namespace: "rslides"
  })
)



