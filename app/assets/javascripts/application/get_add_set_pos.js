//网上找来的一个 查找/设置 textarea光标位置的jquery插件
$.fn.extend({
    getCurPos: function(){
        var e=$(this).get(0);
        e.focus();
        if(e.selectionStart){    //FF
            return e.selectionStart;
        }
        if(document.selection){    //IE
            var r = document.selection.createRange();
            if (r == null) {
                return e.value.length;
            }
            var re = e.createTextRange();
            var rc = re.duplicate();
            re.moveToBookmark(r.getBookmark());
            rc.setEndPoint('EndToStart', re);
            return rc.text.length;
        }
        return e.value.length;
    },
    setCurPos: function(pos) {
        var e=$(this).get(0);
        e.focus();
        if (e.setSelectionRange) {
            e.setSelectionRange(pos, pos);
        } else if (e.createTextRange) {
            var range = e.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    }        
});
