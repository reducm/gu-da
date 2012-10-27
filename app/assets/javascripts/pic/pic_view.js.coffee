class window.PicView
  constructor:(@img)->
    @id = @img.attr("id").match(/\d+/)
    @div = $("<div class=\"inline-block\"></div>")
    @remove_icon = $("<a href='/pictures/#{@id}' data-remote=\"true\" data-method=\"delete\" ><i class=\"icon-remove pull-right\"></i></a>")
    @img.wrap(@div)
    @img.parent()
    @div = @img.parent()
    @div.prepend(@remove_icon)
    @remove_icon.hide()
    @img.css("clear","both")
    @img.css("display","block")
    @div.css("cursor","pointer")
    @remove_icon.addClass("grey")
    @div.on('mouseenter mouseleave', ()=>
      @remove_icon.toggle()
    )
    @remove_icon.on('mouseenter mouseleave', (e)->
      e.stopPropagation()
      e.preventDefault()
      $(this).toggleClass("grey")
    )
    @div.find("a").on("click", ()=>
      @div.loading()
    ).on("ajax:success",(event,data)=>
      console.log(data)
      $.pnotify({text:data.message, type:"success"})
      @div.unloading()
      @div.hide()
    )
    


    
