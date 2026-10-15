#import "../template/east-lansing.typ": east-lansing, panel, subtitle, alert

#show: east-lansing.with(
  title: [EastLansing + spruce],
  subtitle: [A Beamer theme in Typst],
  author: [Hydrangea Kokic],
  institute: [Mathematics Seminar],
  date: [October 15, 2026],
  short-author: [Kokic],
  short-date: [2026-10-15],
  // Optional DIY settings; omitted fields keep their defaults:
  // list-style: (
  //   sizes: (1em, 0.96em, 0.92em), // use (1em,) for equal sizes at every level
  //   leading: 0.55em, spacing: 0.45em,
  //   nested-above: 0.35em, nested-below: 0.2em,
  //   indent: 1em, body-indent: 0.6em,
  //   marker-size: 0.44em, number-box-size: 0.95em,
  // ),
)

= First Section

== This is the slide title #subtitle[This is the slide subtitle]

#panel[Remark][Sample text]

- An item
- Another item
  - Something
    - Something else

+ Thing A
+ Thing B
+ Thing C

= Mathematics

== Blocks and mathematics

#panel[Theorem][
  For every $n in NN$, the sum of the first $n$ odd numbers is $n^2$.
  $ sum_(k=1)^n (2k - 1) = n^2 $
]

#panel(kind: "example")[Example][$1 + 3 + 5 + 7 = 16 = 4^2$.]

#panel(kind: "alert")[Observation][
  The next odd number is the difference $(n+1)^2 - n^2$.
]

= 排版示例

== 中文与双栏排版

#grid(columns: (1fr, 1fr), gutter: 1.5em,
  [
    #panel[勾股定理][
      直角三角形的两条直角边为 $a$、$b$，斜边为 $c$，则
      $ a^2 + b^2 = c^2. $
    ]
  ],
  [
    #panel(kind: "example")[例子][$ 3^2 + 4^2 = 5^2 $]
    - $a = 3$
    - $b = 4$
    - #alert[$c = 5$]
  ],
)
