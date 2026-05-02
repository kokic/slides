
#import "../template/scheme.typ": *
#import "../template/void.typ": *

// #import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, cetz
// #import "@preview/pinit:0.2.2": *

// typst c ./kodama-hypertext/main.typ --root=./

#show link: it => underline(it)
#show quote: set text(style: "italic")
#show quote: set pad(x: 2em)
#show emph: underline
#show raw: set text(font: "Monaco")

#set quote(block: true)
#set par(justify: true)

#let kodama = image("kodama.svg", height: 4em)

#show: beamer.with(
  title: [
    #kodama
    Kodama & network science in #underline[hypertext]
    #footnote[The title pays tribute to Jon Sterling's presentation for _Forester_ a year ago.]
  ],
  subtitle: [],
  author: [],
  end-text: [
    *Thanks!*

    #set text(size: 23pt)

    To see an example, go to: https://kokic.github.io/riemann-surfaces.
  ],
)

#let latex = [L#h(-0.2em)#text(baseline: -0.2em, size: 0.8em)[A]#h(-0.1em)T#h(-0.15em)#text(baseline: 0.2em)[E]#h(-0.1em)X]

#let katex = [K#h(-0.1em)#text(baseline: -0.1em, size: 0.8em)[A]#h(-0.1em)T#h(-0.1em)#text(baseline: 0.2em)[E]#h(-0.1em)X]

#let typst = text("Typst")

#let spaces(x) = $space #x space$
#let quads(x) = $quad #x quad$
#let seq = $spaces(=)$

// #let post-tag = box(baseline: 3.2em, diagram({
//   node((-1, 0), [$X_i: "Post" $])
//   node((1, 0), [$A_i: "Tag"$])
//   edge((-1, 0), (1, 0), [$1:n$], label-side: left, "->", bend: 36deg)
//   edge((1, 0), (-1, 0), [$n:1$], label-side: left, "->", bend: 36deg)
// }))

#let emph-block(fill: rgb("#fe7e7e64"), it) = {
  block(fill: fill, inset: 1em, width: 100%, it)
}

= Episode 1 $spaces(tack.r)$ Genesis

== Derived classic blog concepts

Let's first demonstrate that many concepts in traditional blogs, such as tags, categories, archives, and their respective indexing capabilities, are actually specialized functionalities.

Taking the so-called *tag* function as an example, the other ones are also completely similar:

- `Hugo` ~ https://adityatelange.github.io/hugo-PaperMod
- `Hexo` ~ https://probberechts.github.io/hexo-theme-cactus/cactus-white/public/
- `Zola` ~ https://serene-demo.pages.dev

#pagebreak()

The tag function can be summarized into the following two things:

1. Each post has several tags, with a fixed post $X_i$. The tag $A_j$ within $X_i$ is a link that points to a page displaying all pages that have used tag $A_j$.
2. There is a tag index page called *tags*, which displays all tags ${A_i}_(i in I)$.

// #emph-block[
//   *Fact. *
//   $
//     "Tag / Category / Archive"
//       &seq #post-tag spaces(+) "Tag Index" \
//       &seq (X_i arrows.rl A_i, A_i arrows.rl "Tags")
//   $
// ]


// #stack(dir: ltr)[

// #box[
// #box(stroke: rgb("#ccc"), inset: 1em)[
//   #raw(lang: "yaml", "---")
//   #raw(lang: "yaml", "\ntag1: [Rename1](/tags/tag1.md)") #pin(1)
//   #raw(lang: "yaml", "\ntag2: [Rename2](/tags/tag2.md)")
//   #raw(lang: "yaml", "\n---")

// ] $ X_i: #`post1.md` $
// ]
// ][#h(13em)][

// #box[
// #box(stroke: rgb("#ccc"), inset: 1em)[
//   #raw(lang: "yaml", "---") \
//   #pin(2) #raw(lang: "yaml", "title: Tag Name") \
//   #pin(3) #raw(lang: "yaml", "index: [](./index.md)")
//   #raw(lang: "yaml", "\n---")
// ]
// $ A_j: #`/tags/tag1.md` $
// ]
// ]

// #stack(dir: ltr, spacing: 10em)[

// #box[
// #box(stroke: rgb("#ccc"), inset: 1em)[
// ```yaml
// ---
// title: Tags
// ---
// ```
// ]
// #align(center)[Tags: #`/tags/index.md` #pin(4)]
// ]
// ][
// #v(2em)
// - $A_j$-Backlinks: all posts with tag $A_j$ e.g., $X_i$.
// - Tags-Backlinks: all tags with `[](./index.md)`.
// ]

// #pinit-arrow(1, 2, thickness: 1pt, start-dy: -5pt, end-dy: 20pt, end-dx: -30pt)
// #pinit-arrow(3, 4, thickness: 1pt, start-dy: 18pt, start-dx: -140pt, end-dy: -75pt, end-dx: -45pt)

// #pagebreak()

// #stack(dir: ltr, spacing: 3em)[
//   #v(2em)
//   #box(width: 45%)[
//     This actually expands the functionality of tags, as the use of tags allows for

//     + local renaming.
//     + hiding or display in tag index page.
//     + explaining the meaning of the tag.
//     + etc.

//     In short, every tag page is now considered as the _first class object_, just like a post.

//   ]
// ][
//   #v(-2em)
//   #align(center, diagram({
//     node((-1, 0), [$"Lens"$])
//     node((0, -2), [$"Post"$])
//     node((0, -1), [$"Tag"$])
//     node((0, 0), [$"Category"$])
//     node((0, 1), [$"Archive"$])
//     node((0, 2), [$dots.v$])
//     node((-2, 0), [$X : "Section"$])
//     edge((-1, 0), (0, -2), "->")
//     edge((-1, 0), (0, -1), "->")
//     edge((-1, 0), (0, 0), "->")
//     edge((-1, 0), (0, 1), "->")
//     edge((-1, 0), (0, 2), "->")
//     edge((-2, 0), (-1, 0), "->")
//   }))
// ]

== Why #katex + #typst

#quote(
  attribution: [Jon Sterling \ https://www.forester-notes.org/tfmt-000J/index.xml],
)[
  #katex has a very rudimentary support for commutative diagrams built-in, by emulating the _`amscd`_ package. Unfortunately, this support is completely inadequate for usage by mathematicians today:

  + _Only square diagram shapes are supported_: commutative diagrams in general have diagonal and curved lines, but these are not supported.

  + The rendering of the limited gamut of supported commutative diagrams is broken in most browsers (at least Safari and Firefox). In particular, lines are jagged as they are pieced together from pipes and arrows that are subtly misaligned.
]



== Scientific writing in hypertext

I will continue to quote Jon Sterling's insights. Without a doubt, there is currently no more _rigorous and clear_ understanding of the concept of *"forest"* on the internet.

#emph-block(
  fill: rgb("#cdc1ff88"),
)[
  / Atomicity of scientific notes: https://www.forester-notes.org/tfmt-0007/index.xml

    - a note should capture just one thing, and if possible, all of that thing.
    - A related point is that it should be possible to understand a note by _reading it_, and _traversing the notes_ that it links to and _recursively understanding_ those notes.
    - Traditional mathematical writing ... understanding the meaning of a particular node (e.g. a theorem or definition) usually requires understanding everything that came (textually) before it.
    - we should prefer explicit context over implicit context.
]

It is often difficult to meet the following requirements, and this principle is designed _very ideally_. In practical operation, writers often need to _repeatedly refactor_ their notes to approach these effects.

#emph-block(
  fill: rgb("#cdc1ff88"),
)[

  / Achieving atomicity: https://www.forester-notes.org/tfmt-0008/index.xml

    - no free variables: do not rely on one-off objects that are defined incidentally upwards in the hierarchy; turn them into atomic nodes that can be linked;
    - favor explicit dependency: whenever using a terminology or construction that has been defined elsewhere, link it;
    - notation should be decodable: all notations (except the most very basic) should be recalled via a link.
]


= Episode 2 $spaces(tack.r)$ Infra #link("https://moonbit.community")[moonbit.community]

== Journal, blog, notes and wiki

#emph-block(
  fill: rgb("DDF6D2"),
)[
  *Background*

  Unfortunately, for various reasons, #link("https://kodama-community.github.io/ssg.html")[these] static site generators all have issues when it comes to mathematical writing, which severely limits expressive power.
]

Blogs, wikis, and personal notes may appear to be different types of web pages, but with the concept of _sections_ and _backlinks_, they will be *unified*.

#emph-block()[
  / Presentations: #link(
      "https://www.forester-notes.org/bafkrmidpuo45tjd55ndfgg2ipcwgfaxby7paf6em5nw7tbfgo377gfm3re.pdf",
    )[www.forester-notes.org/ $dots.c$ .pdf]

  Forester is your lecture notes or your public wiki or your private lab journal or your blog.
]


== Schematical issue

/ Hierarchical structure: Markdown, As a popular markup language with multiple incompatible standards, it is mostly regarded as a relatively more cumbersome HTML generation language However, all Markdown #footnote[Even if codeblocks, headers, and some extension syntax e.g., `:::` are abused, it is still not feasible to freely express hierarchical structures. ] inevitably suffers from the problem of hierarchical structure.

/ Grammar Fusion: The expression of formulas is completely embedded in the markdown language, which combines TeX class syntax and HTML content syntax inherited from other markup languages by markdown.

/ Trusted Extension: JavaScript has become the de facto standard for web development, but with the development of hardware and software technology, JavaScript has too many characteristics that are no longer suitable for this era.

  For example, without the module concepts designed and promoted by CommonJS, AMD, and ESM, it is almost difficult to develop large-scale programs using JavaScript. Its modern typed version TypeScript faces similar issues as C++ and C in the past: it must be forced to be compatible with poor JavaScript features at the underlying level.

But the emergence of WASM and _MoonBit_ provided a promising solution to this matter.

/ Give back to LLM:

\

#align(center)[
  #stack(dir: ltr)[
    #quote(attribution: [Jon Sterling])[
      #text(size: 2em)[Arise, symbolic AI!]
    ]
  ][
    #quote(attribution: [网络])[
      #text(size: 2em)[Arise, MoonBit!]
    ]
  ]
]

= Episode 3 $spaces(tack.r)$ Analogues

== From $n$Lab to 1Lab

$n$Lab and 1Lab are basically the final effects that can be presented by _linking_ and _embedding_ functions, but in terms of the tendency towards solidification, because 1Lab defines and derives all terms in _formal language_ i.e., code. This tendency of 1Lab is much stronger.

#emph-block(
  fill: rgb("FDF7E4"),
)[

  / The Purpose of nLab: https://ncatlab.org

  - $n$Lab is a wiki for collaborative work on Mathematics, Physics, and Philosophy — especially (but far from exclusively) from the higher structures point of view: _with a sympathy towards the tools and perspectives_ of homotopy theory / algebraic topology, homotopy type theory, higher category theory and higher categorical algebra.

  - A fundamental idea behind the $n$Lab is that the _linking between pages of a wiki is a profound way to record knowledge_, placing it in a _rich context_.
]

#pagebreak()

#emph-block(
  fill: rgb("71C9CE88"),
)[
  / The Idea of 1Lab: https://1lab.dev

  - 1Lab, A formalised, cross-linked reference resource for mathematics done in Homotopy Type Theory. Unlike the HoTT book, the 1lab is not a “linear” resource: _Concepts are presented as a directed graph_, with _links indicating dependencies_.

  - 1Lab is an experiment in discoverable formalisation: an extensive library of formalised mathematics, presented as an explorable reference resource. Our implementation of a mathematical library, using literate source code, has allowed us a dual approach to the explanation of mathematical concepts: the code and the prose are complementary, and everyone is presented with the opportunity to choose their own balance between the rigid formalisation and the intuitive explanations.
]

== $"Hom"(X, -) <- X -> "Hom"(-, X)$

We have actually come into contact with Forester or Kodama's _philosophy of solidification_ in many places, such as

- Static analysis: For each term, display its _definition_ and _references_.

- Dependency analysis: For each module, calculate its' _"imports"_ and _"imported by"_.

This actually provides two completely different ways to _define_ or _understand_ an object.

#pagebreak()

At a very rough level, we can think of _viewing the definition of an object as understanding how to construct it_, and for types, this is the _constructor_. We can use examples from the category of sets that high school students can fully understand, implying this through _cardinal arithmetic_.

$ |"Hom"({"pt"}, X)| seq |X|, #h(3em) |"Hom"(A,X)| seq |X|^(|A|) $

_More examples that high school students can understand:_

- `data Bool := True | False`.
- ```
  inductive Nat where
    | zero : Nat
    | succ : Nat -> Nat
  ```

So what is the natural number $2$? Our definition of the natural number $2$ now is:

#align(center)[`succ (succ zero)`]

Then we can easily see that the _constructor_ is exactly what $"Hom"(-, X)$ is trying to capture.

Let's shift our perspective to another place.

In fact, if a high school student also tries to understand why this method is useful from the perspective of _cardinal arithmetic_, they may encounter some difficulties. But programming languages once again provide a shortcut to explore the mechanisms.

If we have

$
  Gamma/(#`apple : Fruit`),
  #h(4em)
  Phi/(#`getColor : Fruit -> Color`)
$

then we will get

$ (Gamma, Phi)/(#`getColor apple : Color`) $

With enough of these _projection_ methods, we can also obtain any information about the object. At this point, it can be considered that _viewing the definition of an object is to understand all the uses of that object_. i.e.,

$ "Hom"(X, -) $

_More examples that high school students can understand:_

- $"Hom"(X, "Bool") = 2^X$.
- If for all finite sets $Y$, $|"Hom"(X,Y)| = |Y|^n$, then $|X| = n$.
- In generally, $"Hom"$ can be considered as the way in which all elements of $X$ are _dyed_ into the color of $Y$.

That's why even when designing things like static site generators, we should respect _duality_.
