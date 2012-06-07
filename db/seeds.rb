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
  Article.create(user:u, title:"#{u.name}的test article#{i}", content:<<-EOF
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
  Article.create(user:u, title:"#{u.name}的test article #{i}次", content:<<-EOF
Lisp之魅

长久以来，Lisp一直被许多人视为史上最非凡的编程语言。它不仅在50多年前诞生的时候带来了诸多革命性的创新并极大地影响了后来编程语言的发展，即使在一大批现代语言不断涌现的今天，Lisp的诸多特性仍然未被超越。当各式各样的编程语言摆在面前，我们可以从运行效率、学习曲线、社区活跃度、厂商支持等多种不同的角度进行评判和选择，但我特别看中的一点在于语言能否有效地表达编程者的设计思想。学习C意味着学习如何用过程来表达设计思想，学习Java意味着学习如何用对象来表达设计思想，而虽然Lisp与函数式编程有很大的关系，但学习Lisp绝不仅仅是学习如何用函数表达设计思想。实际上，函数式编程并非Lisp的本质，在已经掌握了lambda、高阶函数、闭包、惰性求值等函数式编程概念之后，学习Lisp仍然大大加深了我对编程的理解。学习Lisp所收获的是如何“自由地”表达你的思想，这正是Lisp最大的魅力所在，也是这门古老的语言仍然具有很强的生命力的根本原因。

Lisp之源

Lisp意为表处理(List Processing)，源自设计者John McCarthy于1960年发表的一篇论文《符号表达式的递归函数及其机器计算》。McCarthy在这篇论文中向我们展示了用一种简单的数据结构S表达式(S-expression)来表示代码和数据，并在此基础上构建一种完整的语言。Lisp语言形式简单、内涵深刻，Paul Graham在《Lisp之根源》中将其对编程的贡献与欧几里德对几何的贡献相提并论。

Lisp之形

然而，与数学世界中简单易懂的欧氏几何形成鲜明对比，程序世界中的Lisp却一直是一种古老而又神秘的存在，真正理解其精妙的人还是少数。从表面上看，Lisp最明显的特征是它“古怪”的S表达式语法。S表达式是一个原子(atom)，或者若干S表达式组成的列表(list)，表达式之间用空格分开，放入一对括号中。“列表“这个术语可能会容易让人联想到数据结构中的链表之类的线形结构，实际上，Lisp的列表是一种可嵌套的树形结构。下面是一些S表达式的例子:
```
foo
()
(a b (c d) e)
(+ (* 2 3) 5)
(defun factorial (N)
    (if (= N 1)
        1
        (* N (factorial (- N 1)))
    )
)
```
Lisp之道

一门语言能否有效地表达编程者的设计思想取决于其抽象机制的语义表达能力。根据抽象机制的不同，语言的抽象机制形成了面向过程、面向对象、函数式、并发式等不同的范式。当你采用某一种语言，基本上就表示你已经“面向XXX“了，你的思维方式和解决问题的手段就会依赖于语言所提供的抽象方式。比如，采用Java语言通常意味着采用面向对象分析设计；采用Erlang通常意味着按Actor模型对并发任务进行建模。

有经验的程序员都知道，无论是面向XXX编程，程序设计都有一条“抽象原则“：What与How解耦。但是，普通语言的问题就在于表达What的手段非常有限，无非是过程、类、接口、函数等几种方式，而诸多领域问题是无法直接抽象为函数或接口的。比如，你完全可以在C语言中定义若干函数来做到make file所做的事情，但C代码很难像make file那样声明式地体现出target、depends等语义，它们只会作为实现细节被淹没在一个个的C函数之中。采用OOP或是FP等其它范式也会遇到同样的困难，也就是说make file语言所代表的抽象维度与面向过程、OOP以及FP的抽象维度是正交的，使得各种范式无法直接表达出make file的语义。这就是普通语言的“刚性”特征，它要求我们必须以语言的抽象维度去分析和解决问题，把问题映射到语言的基本语法和语义。

更进一步，如果仔细探究这种刚性的根源，我们会发现正是由于普通语言语法和语义的紧耦合造成了这种刚性。比如，C语言中printf(“hello %s”, name)符合函数调用语法，它表达了函数调用语义，除此之外别无他义；Java中interface IRunnable { … }符合接口定义语法，它表达了接口定义语义，除此之外别无他义。如果你认为“语法和语义紧耦合“是理所当然的，看不出这有什么问题，那么理解Lisp就会让你对此产生更深的认识。

当你看到Lisp的(f a (b c))的时候，你会想到什么？会不会马上联想到函数求值或是宏扩展？就像在C语言里看到gcd(10, 15)马上想到函数调用，或者在Java里看到class A马上想到类定义一样。如果真是这样，那它就是你理解Lisp的一道障碍，因为你已经习惯了顺着语言去思考，总是在想这一句话机器怎么解释执行？那一句话又对应语言的哪个特性？理解Lisp要反过来，让语言顺着你，Lisp的(f a (b c))可以是任何语义，完全由你来定，它可以是函数定义、类定义、数据库查询、文件依赖关系，异步任务的执行关系，业务规则 …

下面我准备先通过几个具体的例子逐步展示Lisp的本质。需要说明的是，由于Lisp的S表达式和XML的语法形式都是一种树形结构，在语义表达方面二者并无本质的差别。所以，为了理解方便，下面我暂且用多数人更为熟悉的XML来写代码，请记住我们可以很轻易地把XML代码和Lisp代码相互转换。

EOF
)
end


