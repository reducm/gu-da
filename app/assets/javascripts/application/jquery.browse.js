//在元素上面放一个隐藏打开上传多个文件input的小插件
//用法:
//input = $(element).browseElement()
//input.on("drop",()->); input.on("change",(event)->
//event.stopPropagation()
//event.preventDefault()
//files = event.originalEvent.target.files
//that.create_upload_button(that.ul)
//that.imgs = that.makePicArr(files)
//)
(function($){ 
  $.fn.browseElement = function(single){
    var input;
    if(single) {
      input = $("<input type='file'>");
    }else {
      input = $("<input type='file' multiple>");
    }

    input.css({
      "position":     "absolute",
      "z-index":      9999,
      "cursor":       "pointer",
      "-moz-opacity": "0",
      "filter":       "alpha(opacity: 0)",
      "opacity":      "0"
    }).attr("id", "hide_input");

    input.mouseout(function(){
      input.detach();
    });

    var element = $(this);

    element.mouseover(function(){
      input.offset(element.offset());
      input.width(element.outerWidth());
      input.height(element.outerHeight());
      $("body").append(input);
    });

    return input;
  };
})(jQuery);
