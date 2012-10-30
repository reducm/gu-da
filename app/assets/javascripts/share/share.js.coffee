$(document).ready(->
  share_modal = $("#ShareModal")
  if share_modal[0]
    share_modal.modal()
  
  share_modal.on("hidden",()->
    $.removeCookie(("update_article"),{path:'/'})
    $.removeCookie(("create_article"),{path:'/'})
  )
)
