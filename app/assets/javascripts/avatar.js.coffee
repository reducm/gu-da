$(document).ready(()->
  input = $(".avatar_preview .btn").browseElement(true)
  preview = $(".avatar_temp")
  upload = $(".avatar_upload").parent()
  [bwidth, bheight] = [preview.width(), preview.height()] #截图框长宽
  [pwidth, pheight] = [upload.width(), upload.height()] #上传预览框长宽
  jcrop = 1
  input.on("change", (event)->
    event.stopPropagation()
    event.preventDefault()
    #console.log(event)
    file = event.originalEvent.target.files[0]
    fr = new FileReader()
    [owidth, oheight] = [0, 0]
    fr.onload = (e)->
      preview.html("<img src='#{e.target.result}' />")
      $(".avatar_upload").attr("src", e.target.result)
      preview.children("img").Jcrop({
        #onChange: update_crop
        onSelect: update_crop
        aspectRatio: 1
      })
      update_crop = (coords)->
        #if owidth > oheight #定比例
          #proportion = owidth / bwidth
        #[rx, ry, rw, rh] = [coords.x*proportion, coords.y*proportion,coords.w*proportion, coords.h*proportion] #rx, ry, rw ,rh 实际应该在图片上截取的renc
        #p_proportion = pwidth / rw
        #$('.avatar_upload').css({
          #width: Math.round(owidth*p_proportion) + 'px',
          #marginLeft: '-' + Math.round(rx * p_proportion) + 'px',
          #marginTop: '-' + Math.round(ry * p_proportion) + 'px'
          #display: 'block'
        #})
        console.log(coords.x, coords.y, coords.w, coords.h)
        false

    fr.readAsDataURL(file)
        
  )
)

