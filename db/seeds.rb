#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = User.create([{name:'jas',password:'aaaaaa',email:'a@a.com',description:'fuck that shit'},
                     {name:'fff',email:'f@f.com',password:'ffffff',description:'fuck that firefox'}
])

users.each_with_index do |u,i|
  Setting.create(user:u, blog_name:"#{u.name}的fucking博客")
  Article.create(user:u, title:"test article ", content:<<-EOF
在上一篇。作者提到了 「New-product introduction model」有非常大的機率，會讓一個 Startup 從車站一開始出發，終點就注定是地獄。整理歸納了的九宗罪，多數 Startup 都是因為這九宗罪而死掉的。

1. Assuming “I Know What the Customer Wants”

第一條是創辦人盲目的認為自己：

知道客戶是哪些人
知道客戶要什麼
知道怎麼把產品賣給客戶
任何冷靜的觀察者從 Day 1 就會觀察到一個客觀的事實：一個 Startup 一開始不會有任何客戶。除非這個 Founder 原先就是這個領域的專家。

不然創辦人往往只能用「猜」的去猜測「會有哪些客戶」、「存在哪些問題需要解決」、和「可能的商業模式」。

而使用 「New-product introduction model」會讓創辦人將猜測當作是事實，在跟第一個真正的客戶聊過之前，開始設計產品和花大錢。

想要成功，創辦人需要將假設與猜測設法僅快的轉變成「事實」。唯一的途徑就是走出室外真正的與客戶攀談了解需求。當初的假設是否正確，僅快修正自己錯誤的猜想。

2. The “I Know What Features to Build” Flaw

第二條跟第一條有點相關。

創辦人會自以為懂他的用戶，先行假設出一堆他覺得用戶會需要的功能。「閉門」使用傳統的產品開發流程，精心打造一整套完整功能的產品。

但…等等，這是 Startup 應該做的事嗎？

不。這種方法通常是「Company」在已經有客戶的情況下才可以這樣作。

傳統式瀑布開發法，通常一開始起頭，就需要 1-2 年的時間。進度的衡量方式是在推出前究竟寫了多少行 code 以及製造了多少硬體出來。

但問題是，在開發過程中。不跟用戶進行直接且持續的交流，是很難知道哪一項功能才真正的吸引人。

在產品完工之後才再進行修改，代價往往高昂且耗時。巨大的開發能量被浪費，無數小時的工作成果被當成垃圾。

但諷刺的是，很多 startup 常愛用這種傳統的方式去開發產品。

3. Focus on Launch Date

傳統的開發流程會出現：Engineering、Sales 和 Marketing 的時程綁死在一個不能修改的「上線日」。

Engineering 的開發流程中通常會有 alpha / beta / release 三個階段，確保產品能夠有時間空間能被改善到能 deliver 的程度。

好笑的是，往往上線日，真正上線的產品的品質和進度卻往往都是「剛做完」而已。而不是到公司已經知道怎樣去行銷或者販售這個產品的程度。

但幾乎在每一間 startup，不管到底準備好沒有，不能修改的「上線日」卻往往跟「first customer ship」綁在一起。甚至更慘的是，有些投資者的財務計畫甚至跟這個時間也綁在一起。

投資者往往會說：「Why, of course that’s what you do. Getting the product to market is what sales and marketing people do in startups. That’s how a startup make money.」

這是 絕對致命的建議 ，千萬別理他們。（這句話是書上講的，不是我講的）

每一家 startup 或者是 company 當然都想要能夠一開始就順利的販售出新做出來的產品，並且能夠執行極佳的行銷策略。但這個夢只有在公司知道「誰會負責賣」以及「為什麼客戶願意買」的前提下才會達成。

但是多半的情形是，大家一廂情願的只會認為：有著良好的「Engineering Execution」，客戶就會買單…

一次又一次的，只有在上線之後，Startup 才會發現沒有足夠多的用戶會使用他們的網站、轉化成有效的訂單。早期用戶數不夠提升到主流市場。不能解決 high-value 的問題。更或者是配送成本過於昂貴。

發現這些事情已經夠慘了。

更慘的是情況變成騎虎難下的局面，已經花了很多錢卻沒有期待的效益。只好開始找問題在哪裡，看看還有沒有機會修正…

Webvan 的情況是，當初他們更身處在 dot-com 狂燥症熱錢到處是的年代，又加重了這樣的情形。公司在前半年只有 400 人，後半年就補了 500 人進來；在初期只開了一間值 4000 萬美金的配送中心，不久之後，又瞬間開設了 15 間相同等級的配送中心。

你問他們為什麼要這樣作？喔。因為這是 Business Plan 上寫的。不管真實狀況是不是需要。

EOF
)
end


