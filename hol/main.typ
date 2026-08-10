
#set page(paper: "presentation-16-9", fill: rgb("#c9b794"))
// rgb("#d3ba84")

#set text(font: "Huiwen-mincho", size: 20pt)
#show math.equation: set text(font: "Maple Mono NF")

一阶逻辑以几个版本实现。得益于把列表巧妙地编码为嵌套的函数应用，高阶合一可以达到结合性合一 (associative unification) 的效果 (Huet 和 Lang, 1978). 因此我们可以用序列变量来表述相继式演算. 例如，一个基本相继式是左右两侧拥有共同公式的相继式; 每个基本相继式显然都是有效的. 基本相继式的一个图式可以直接在 Isabelle 中表示: 

#align(center)[
?Γ, ?P, ?Γ′ #h(1em) ⊢ #h(1em)  ?Δ, ?P, ?Δ′
]

同样, 问号表示元变量. 注意, 目标中的元变量表示未知数, 而规则中的元变量则表达规则的图式结构. 

作为元逻辑的一个例子, 让我们表示经典一阶逻辑. 以下是标准的自然演绎系统 (Prawitz, 1965), 其中 ⊥ 表示假, 而 ¬P 是 P ⊃ ⊥ 的缩写. 
