//= require_tree ./pnotify
$(document).ready(function(){
  $.pnotify.defaults.history = false;
  $.pnotify.defaults.addclass = 'jpnotify';
});


//title            : false - The notice's title.
//title_escape     : false - Whether to escape the content of the title. (Not allow HTML.)
//text             : false - The notice's text.
//text_escape      : false - Whether to escape the content of the text. (Not allow HTML.)
//styling          : "bootstrap" - What styling classes to use. (Can be either jqueryui or bootstrap.)
//addclass         : "" - Additional classes to be added to the notice. (For custom styling.)
//cornerclass      : "" - Class to be added to the notice for corner styling.
//nonblock         : false - Create a non-blocking notice. It lets the user click elements underneath it.
//nonblock_opacity : .2 - The opacity of the notice (if it's non-blocking) when the mouse is over it.
//history          : true - Display a pull down menu to redisplay previous notices, and place the notice in the history.
//auto_display     : true - Display the notice when it is created. Turn this off to add notifications to the history without displaying them.
//width            : "300px" - Width of the notice.
//min_height       : "16px" - Minimum height of the notice. It will expand to fit content.
//type             : "notice" - Type of the notice. "notice", "info", "success", or "error".
//icon             : true - Set icon to true to use the default icon for the selected style/type, false for no icon, or a string for your own icon class.
//animation        : "fade" - The animation to use when displaying and hiding the notice. "none", "show", "fade", and "slide" are built in to jQuery. Others require jQuery UI. Use an object with effect_in and effect_out to use different effects.
//animate_speed    : "slow" - Speed at which the notice animates in and out. "slow", "def" or "normal", "fast" or number of milliseconds.
//opacity          : 1 - Opacity of the notice.
//shadow           : true - Display a drop shadow.
//closer           : true - Provide a button for the user to manually close the notice.
//closer_hover     : true - Only show the closer button on hover.
//sticker          : true - Provide a button for the user to manually stick the notice.
//sticker_hover    : true - Only show the sticker button on hover.
//hide             : true - After a delay, remove the notice.
//delay            : 8000 - Delay in milliseconds before the notice is removed.
//mouse_reset      : true - Reset the hide timer if the mouse moves over the notice.
//remove           : true - Remove the notice's elements from the DOM after it is removed.
//insert_brs       : true - Change new lines to br tags.
//stack            : {"dir1"                                                                                                                                                                                                                          : "down", "dir2" : "left", "push" : "bottom", "spacing1" : 25, "spacing2" : 25} - The stack on which the notices will be placed. Also controls the direction the notices stack.
