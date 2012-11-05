$(document).ready(()->
    #umodal = $("#upload_pic_modal")
    #ul_upload = $("#ul_for_pic")
    #ul_showpic = $("#ul_showpic")


    #callback = (data)->
      #ul_upload.empty()
      #umodal.modal("hide")
      #for pic in data
        #ul_showpic.children(".btn").after("<li><img src=\"#{pic}\" /></li>")
    
    #umodal.on("shown",()->
      #pc = new Blog.PicturesUpload({el:"#upload_pic_modal"})
    #)
    #pc = new PicController($(".drop_file"), ul_upload, "/pictures", "100px", {pictureable_type:'User', pictureable_id:guda.user_id}, $(".drag_to"), 4, callback)
)
