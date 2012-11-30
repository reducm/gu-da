/*
*      editor.js - a simple textarea2codeeditor transformer
*      
*      More information available at http://editor.scienceco.de/
*
*      Copyright 2011 Florian Stascheck <levu@scienceco.de>
*
*      This program is free software; you can redistribute it and/or modify
*      it under the terms of the GNU General Public License as published by
*      the Free Software Foundation; either version 2 of the License, or
*      (at your option) any later version.
*
*      This program is distributed in the hope that it will be useful,
*      but WITHOUT ANY WARRANTY; without even the implied warranty of
*      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*      GNU General Public License for more details.
*
*      You should have received a copy of the GNU General Public License
*      along with this program; if not, write to the Free Software
*      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
*      MA 02110-1301, USA.
*
*
*/

(function ($) {
    $.fn.getSel = function() {
        var o = (function() {
            var range, stored_range, start;
            if (document.selection) {
                //http://the-stickman.com/web-development/javascript/finding-selection-cursor-position-in-a-textarea-in-internet-explorer/
                // The current selection
                range = document.selection.createRange();
                // We'll use this as a 'dummy'
                stored_range = range.duplicate();
                // Select all text
                stored_range.moveToElementText( this[0] );
                // Now move 'dummy' end point to end point of original range
                stored_range.setEndPoint( 'EndToEnd', range );
                // Now we can calculate start and end points
                start = stored_range.text.length - range.text.length;
                start -= stored_range.text.count('\n');
                return [start, start+range.text.length];
            }
            return [this[0].selectionStart, this[0].selectionEnd];
        }).call(this);
        if (isNaN(o[0]) || isNaN(o[1])) {
            o = [0, 0];
        }
        o.start = o[0];
        o.end = o[1];
        o.text = this.val().substr(o[0], o[1] - o[0]);
        return o;
    };
    $.fn.setSel = function(from, to) {
        var range;
        if (document.selection) {
            range = document.selection.createRange();
            range.moveToElementText(this[0]);
            range.moveStart('character', from);
            range.moveEnd('character', this.text().length - to);
        } else {
            this[0].selectionStart = from;
            this[0].selectionEnd = to;
            this[0].focus();
        }
        return this;
    };
    String.prototype.count = function(subject) {
        return this.substrPos(subject).length;
    };
    String.prototype.substrPos = function(substr) { //http://stackoverflow.com/questions/6363580/get-the-positions-of-the-substrings-before-replacing/6363765#6363765
        var arr=[], idx=-1;
        while ((idx=this.indexOf(substr,idx+1)) > -1) {
            arr.push(idx);
        }
        return arr;
    };
    String.prototype.times = function(n) {
        return Array.prototype.join.call({length:n+1}, this);
    };
    $.fn.editor = function() {
        var ret = null, editorify = function(textfield) {
            var api = {
                indentWidth: 4,
                lasthighlight: '',
                textfield: textfield,
                tabProducesSpace: true,
                keydown: function(e) {},
                keyup: function(e) {},
                insertBefore: function(text) {
                    return api.insertAround(text, '');
                },
                insertAfter: function(text) {
                    return api.insertAround('', text);
                },
                insertAround: function(before, after) {
                    var txt, t, o = textfield.getSel();
                    t = textfield[0].scrollTop;
                    txt = textfield.val();
                    textfield.val(txt.substr(0, o.start) + before + txt.substr(o.start, o.text.length) + after + txt.substr(o.end));
                    textfield.setSel(o.start + before.length, o.end + before.length);
                    textfield[0].scrollTop = t;
                    return api;
                },
                insertInside: function(before, after) {
                    return api.replaceSelection(before + api.selectedText() + after);
                },
                replaceSelection: function(replaceWith) {
                    var txt, t, o = textfield.getSel();
                    t = textfield[0].scrollTop;
                    txt = textfield.val();
                    textfield.val(txt.substr(0, o.start) + replaceWith + txt.substr(o.end));
                    textfield.setSel(o.start, o.start + replaceWith.length);
                    textfield[0].scrollTop = t;
                    return api;
                },
                replace: function(subject, replaceWith, maxcount) {
                    maxcount = maxcount || false;
                    var t, i, count, pos, s, o = textfield[0].scrollTop;
                    t = textfield.val();
                    i = t.indexOf(subject);
                    if (i != -1) {
                        count = 0;
                        pos = 0;
                        while((i != -1) && ((maxcount === false) || (count < maxcount))) {
                            pos = i;
                            t = t.replace(subject, replaceWith);
                            i = t.indexOf(subject);
                            count++;
                        }
                        textfield.val(t);
                        s = pos + replaceWith.length;
                        textfield.setSel(s, s);
                        textfield[0].scrollTop = o;
                    }
                    return api;
                },
                highlightFirstOccurence: function(subject, from) {
                    from = from || 0;
                    var idx, t, o = textfield[0].scrollTop;
                    t = textfield.val();
                    idx = t.indexOf(subject, from);
                    if (idx != -1) {
                        api.lasthighlight = subject;
                        textfield.setSel(idx, idx+subject.length);
                        textfield[0].scrollTop = o;
                    }
                },
                highlightNextOccurence: function(subject) {
                    subject = subject || api.lasthighlight;
                    return api.highlightFirstOccurence(subject, textfield.getSel().end);
                },
                focus: function() {
                    textfield.focus();
                    return api;
                },
                currentLine: function(array) {
                    array = ((array === undefined) || (array === null)) ? false : array;
                    var start, s, end, t = textfield.val();
                    s = textfield.getSel();
                    start = t.substr(0, s.start).count("\n");
                    if (array) {
                        end = t.substr(0, s.end).count("\n");
                        return [start, end];
                    } else {
                        return start;
                    }
                },
                posInLine: function(end) {
                    end = ((end === undefined) || (end === null)) ? false : end;
                    var s, pos, lines, i, j=0, l, t = textfield.val();
                    s = textfield.getSel();
                    pos = end ? s.end : s.start;
                    lines = t.split("\n");
                    for (i = 0; i < lines.length; i++) {
                        l = lines[i].length;
                        if (j+1+l > pos) {
                            return pos - j;
                        }
                        j += l + 1;
                    }
                    return 0;
                },
                lineText: function(linenr, lineText) {
                    linenr = linenr || api.currentLine();
                    var lines, s, o, oldLength, t = textfield.val();
                    lines = t.split("\n");
                    if (lineText !== undefined) {
                        o = textfield[0].scrollTop;
                        s = textfield.getSel();
                        oldLength = lines[linenr] ? lines[linenr].length : 0;
                        lineText += '';
                        lines[linenr] = lineText;
                        textfield.val(lines.join("\n"));
                        textfield.setSel(s.start - oldLength + lineText.length, s.end - oldLength + lineText.length);
                        textfield[0].scrollTop = o;
                    } else {
                        if (lines[linenr]) {
                            return lines[linenr];
                        }
                        return '';
                    }
                },
                moveSel: function(by, stayInLine) {
                    var p, newp, l, s = textfield.getSel();
                    p = api.posInLine();
                    newp = p + by;
                    if (stayInLine) {
                        l = api.lineText().length;
                        if (newp < 0) {
                            newp = 0;
                        }
                        if (newp > l) {
                            newp = l;
                        }
                    }
                    s.start += newp - p;
                    s.end += newp - p;
                    textfield.setSel(s.start, s.end);
                },
                indentLine: function(from, to, by) {
                    if (from < 0) { //its indentLine(by)
                        by = from;
                        from = null;
                    }
                    if (from === undefined) {
                        from = api.currentLine(true);
                    }
                    if (!!from.length) {
                        to = from[1];
                        from = from[0];
                    } else {
                        to = to || from;
                    }
                    if (isNaN(by)) {
                        by = api.indentWidth;
                    }
                    var j, firstlineoutdented = 0, outdented = 0, i, lines, s = textfield.getSel(), t = textfield.val(), o = textfield[0].scrollTop;
                    lines = t.split("\n");
                    for (i=from; i <= to; i++) {
                        if (by > 0) {
                            lines[i] = " ".times(by) + lines[i];
                        } else {
                            for (j=0; j > by; j--) {
                                if (lines[i].substr(0, 1) != ' ') {
                                    break;
                                }
                                lines[i] = lines[i].substr(1);
                                outdented++;
                                if (i == from) {
                                    firstlineoutdented++;
                                }
                            }
                        }
                    }
                    t = lines.join("\n");
                    textfield.val(t);
                    if (by > 0) {
                        s.start +=  by;
                        s.end += (to-from+1) * by;
                    } else {
                        s.start -= firstlineoutdented;
                        s.end -= outdented;
                    }
                    textfield.setSel(s.start, s.end);
                    textfield[0].scrollTop = o;
                    return textfield;
                },
                outdentLine: function(from, to) {
                    return api.indentLine(from, to, -api.indentWidth);
                },
                adjustLine: function(linenr) {
                    linenr = linenr || api.currentLine();
                    if (linenr < 0) {
                        linenr = 0;
                    }
                    if (linenr === 0) {
                        return;
                        //the first line can't be adjusted because for adjusting we need lines before
                    }
                    var l, lineBeforeIndent, i, j=0, selEndAfterLine = true, selStartAfterLine = true, lines, s = textfield.getSel(), t = textfield.val(), o = textfield[0].scrollTop, currentLineIndent;
                    lines = t.split("\n");
                    for(i=0; i < linenr; i++) {
                        j+=lines[i].length+1;
                        if (j > s.start) {
                            selStartAfterLine = false;
                        }
                        if (j > s.end) {
                            selEndAfterLine = false;
                        }
                    }
                    l=lines[i-1];
                    lineBeforeIndent = 0;
                    for(j=0; j < l.length; j++) {
                        if (l.substr(j, 1) == ' ') {
                            lineBeforeIndent++;
                        } else {
                            break;
                        }
                    }
                    if (l.substr(l.length - 1) == '{') {
                        lineBeforeIndent += api.indentWidth;
                    }
                    l=lines[i];
                    currentLineIndent = 0;
                    for(j=0; j < l.length; j++) {
                        if (l.substr(j, 1) == ' ') {
                            currentLineIndent++;
                        } else {
                            break;
                        }
                    }
                    if (l.substr(currentLineIndent, 1) == '}') {
                        lineBeforeIndent -= api.indentWidth;
                        if (lineBeforeIndent < 0) {
                            lineBeforeIndent = 0;
                        }
                    }
                    api.indentLine(i, i, lineBeforeIndent - currentLineIndent);
                    if (selStartAfterLine) {
                        s.start += lineBeforeIndent - currentLineIndent;
                    }
                    if (selEndAfterLine) {
                        s.end += lineBeforeIndent - currentLineIndent;
                    }
                    textfield.setSel(s.start, s.end);
                    textfield[0].scrollTop = o;
                    return textfield;
                }
            };
            var enterkeydownline = null, braceclosekey = null;
            textfield.keydown(function(e) {
                var p, l, i, sel, pm, s, m;
                if (e.which == 9) {
                    e.preventDefault();
                    if (textfield.getSel().text === '') {
                        if (e.shiftKey) {
                            p = api.posInLine();
                            pm = p % api.indentWidth;
                            if (pm === 0) {
                                pm = api.indentWidth;
                            }
                            l = api.lineText();
                            if (api.tabProducesSpace) {
                                if (l.substr(p-pm, pm) == ' '.times(pm)) {
                                    api.lineText(api.currentLine(), l.substr(0, p-pm) + l.substr(p));
                                } else {
                                    api.moveSel(-api.indentWidth, true);
                                }
                            } else {
                                if (l.substr(p-1, 1) == "\t") {
                                    api.lineText(api.currentLine(), l.substr(0, p-1) + l.substr(p));
                                } else {
                                    api.moveSel(-api.indentWidth, true);
                                }
                            }
                        } else {
                            if (api.tabProducesSpace) {
                                api.insertBefore(' '.times(api.indentWidth - (api.posInLine() % api.indentWidth)));
                            } else {
                                api.insertBefore("\t");
                            }
                        }
                    } else {
                        if (e.shiftKey) {
                            api.outdentLine();
                        } else {
                            api.indentLine();
                        }
                    }
                } else if (e.which == 13) { //enter
                    if (!(e.shiftKey || e.ctrlKey || e.altKey)) {
                        if (enterkeydownline === null) {
                            enterkeydownline = api.currentLine();
                        }
                    }
                } else if (e.which == 36) { //home
                    if (!(e.ctrlKey || e.altKey)) {
                        p = api.posInLine();
                        l = api.lineText();
                        i = 0;
                        for (; i < l.length; i++) {
                            if (l.substr(i, 1) != (api.tabProducesSpace ? ' ' : "\t")) {
                                break;
                            }
                        }
                        if (e.shiftKey) {
                            sel = textfield.getSel();
                            if (p == i) { //mark the whole line
                                textfield.setSel(sel.start - p, sel.end);
                            } else { //mark from indentation to end
                                textfield.setSel(sel.start + i - p, sel.end);
                            }
                        } else {
                            s = 0;
                            if (p == i) {
                                s = -i; //go to 0
                            } else {
                                s = i-p; // go to i
                            }
                            api.moveSel(s);
                        }
                        e.preventDefault();
                    }
                } else if (e.which == 8) { //backspace
                    if (api.tabProducesSpace && (!(e.shiftKey || e.ctrlKey || e.altKey))) {
                        p = api.posInLine();
                        l = api.lineText();
                        i = 0;
                        for (; i < l.length; i++) {
                            if (l.substr(i, 1) != ' ') {
                                break;
                            }
                        }
                        sel = textfield.getSel();
                        if ((p > 0) && (p <= i) && (sel.start == sel.end)) {
                            e.preventDefault();
                            m = p % api.indentWidth;
                            if (m === 0) {
                                m = api.indentWidth;
                            }
                            api.lineText(api.currentLine(), l.substr(0, p - m) + l.substr(p));
                        }
                    }
                }
                api.keydown(e);
            }).keypress(function(e) {
                if (String.fromCharCode(e.charCode) == '}') {
                    api.replaceSelection('').insertBefore('}');//.adjustLine();
                    e.preventDefault();
                }
            }).keyup(function(e) {
                if (e.which == 13) {
                    var to, from = enterkeydownline+1;
                    to = api.currentLine();
                    for (; from <= to; from++) {
                        //api.adjustLine(from);
                    }
                    enterkeydownline = null;
                }
                api.keyup(e);
            });
            return api;
        }, textfield, i;
        for (i=0; i<this.length; i++) {
            textfield = $(this[i]);
            ret = editorify(textfield);
        }
        return ret;
    };
    })(jQuery);

