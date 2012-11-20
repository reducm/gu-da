$.fn.dontScrollParent = function(){
  //this.bind('mousewheel DOMMouseScroll',function(e){
    //var delta = e.originalEvent.wheelDelta || -e.originalEvent.detail;
    //if (delta > 0 && $(this).scrollTop() <= 0)
      //return false;
    //if (delta < 0 && $(this).scrollTop() >= this.scrollHeight - $(this).height())
      //return false;
    //return true;
  //});

  var height = this.height();
  var scrollHeight = this.get(0).scrollHeight;
  that = this[0]
  this.bind('mousewheel', function(e, d) {
    if((that.scrollTop === (scrollHeight - height) && d < 0) || (that.scrollTop === 0 && d > 0)) {
            e.preventDefault();
    }
  });
};
