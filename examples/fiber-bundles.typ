// Fiber bundles — a short deck built on the standalone EastLansing theme.
//   typst compile fiber-bundles.typ fiber-bundles.pdf
//
// Pages: a cover (automatic), then
//   1. what a fiber bundle is,
//   2. why the gluing is the whole content (cylinder vs Möbius band),
//   3. examples, and what the definition buys you.
#import "../template/east-lansing.typ": east-lansing, panel, alert
#import "@preview/cetz:0.4.2"

#let green = rgb("#005229")
#let band = rgb("#99c2ad")
#let ink = rgb("#3d3d3d")

#show: east-lansing.with(
  title: [Fiber Bundles: One Shape, Repeated Over Every Point],
  subtitle: [What is the same everywhere, and what can only twist globally],
  author: [DeepSeek V4.1 Flash],
  date: [October 2026],
  short-title: [Fiber bundles],
  width: 160mm,
  height: 90mm,
)

#set par(justify: true)

= Fiber bundles

== A fiber bundle is one fixed shape, one copy over every point of a base

#grid(
  columns: (1fr, 1.02fr),
  gutter: 10pt,
  align: horizon,
  [
    A bundle is a space $E$ built by dragging one fixed shape $F$ along a base $B$:

    - *Total space* $E$: all the points.
    - *Base* $B$: the positions $F$ moves along.
    - *Fiber* $F$: the shape, repeated at each position.
    - *Projection* $pi: E -> B$: the base point underneath.
  ],
  [
    #align(center, cetz.canvas(length: 1cm, {
      import cetz.draw: *
      // the base
      line((0, 0), (6.6, 0), stroke: (paint: green, thickness: 1.6pt))
      // one copy of the fiber over each position drawn
      for x in (0.4, 1.35, 2.3, 4.5, 5.45, 6.4) {
        line((x, 0.05), (x, 1.8), stroke: (paint: band, thickness: 1pt))
      }
      // the fiber over the point we look at
      line((3.3, 0.05), (3.3, 1.8), stroke: (paint: green, thickness: 1.5pt))
      // a point of the total space, its base point, and the projection between them
      circle((3.3, 1.05), radius: 0.055, fill: ink, stroke: none)
      circle((3.3, 0), radius: 0.055, fill: ink, stroke: none)
      bezier(
        (3.3, 1.05), (3.85, 0.8), (3.85, 0.3), (3.42, 0.05),
        stroke: (paint: ink, thickness: 0.9pt),
        mark: (end: "stealth", fill: ink, stroke: ink, scale: 1.2),
      )
      // labels
      content((0, 2.45), [total space $E$], anchor: "south-west")
      content((3.36, 1.82), [fiber $pi^(-1)(b) tilde.equiv F$], anchor: "south-west")
      content((3.24, 1.1), [$p$], anchor: "east")
      content((3.3, 0), [$b$], anchor: "north")
      content((3.98, 0.62), [$pi$], anchor: "west")
      content((0, 0.02), [base $B$], anchor: "north")
      content((6.6, 0.02), [$dots$], anchor: "north")
    }))
  ],
)

#v(3pt)

#panel[Local triviality: the one condition, and a weak one][
  Around every point of the base there is a patch $U$ over which the bundle is an ordinary product, $pi^(-1)(U) tilde.equiv U times F$. Nothing local can tell a bundle from a product, so everything interesting about a bundle is global.
]

== One rectangle, two bundles: only the gluing differs

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  align: top,
  [
    #align(center, cetz.canvas(length: 1cm, padding: (bottom: 5pt), {
      import cetz.draw: *
      // the rectangle: base direction across, fiber direction up
      rect((0, 0), (3.2, 2), stroke: (paint: rgb("#b9c6bf"), thickness: 0.5pt))
      for x in (0.46, 1.0, 1.6, 2.14, 2.74) {
        line((x, 0.09), (x, 1.91), stroke: (paint: band, thickness: 1pt))
      }
      // the two long edges
      line((0, 2), (3.2, 2), stroke: (paint: green, thickness: 1.8pt))
      line((0, 0), (3.2, 0), stroke: (paint: green, thickness: 1.8pt))
      // the two long edges, named
      content((0.11, 1.7), text(size: 8pt)[1], anchor: "west")
      content((0.11, 0.3), text(size: 8pt)[2], anchor: "west")
      // the two ends are glued the same way round
      line((-0.3, 0.45), (-0.3, 1.55), stroke: (paint: green, thickness: 0.9pt),
        mark: (end: "stealth", fill: green, stroke: green, scale: 1.1))
      line((3.5, 0.45), (3.5, 1.55), stroke: (paint: green, thickness: 0.9pt),
        mark: (end: "stealth", fill: green, stroke: green, scale: 1.1))
    }))
    #align(center, text(size: 9pt)[*Cylinder*: ends glued straight — edges 1 and 2 stay two circles, so $E = S^1 times I$.])
  ],
  [
    #align(center, cetz.canvas(length: 1cm, padding: (bottom: 5pt), {
      import cetz.draw: *
      rect((0, 0), (3.2, 2), stroke: (paint: rgb("#b9c6bf"), thickness: 0.5pt))
      for x in (0.46, 1.0, 1.6, 2.14, 2.74) {
        line((x, 0.09), (x, 1.91), stroke: (paint: band, thickness: 1pt))
      }
      // the two long edges join into one circle: drawn in one colour
      line((0, 2), (3.2, 2), stroke: (paint: green, thickness: 1.8pt))
      line((0, 0), (3.2, 0), stroke: (paint: green, thickness: 1.8pt))
      // the two long edges, named
      content((0.11, 1.7), text(size: 8pt)[1], anchor: "west")
      content((0.11, 0.3), text(size: 8pt)[2], anchor: "west")
      // the two ends are glued after a half turn
      line((-0.3, 0.45), (-0.3, 1.55), stroke: (paint: green, thickness: 0.9pt),
        mark: (end: "stealth", fill: green, stroke: green, scale: 1.1))
      line((3.5, 1.55), (3.5, 0.45), stroke: (paint: green, thickness: 0.9pt),
        mark: (end: "stealth", fill: green, stroke: green, scale: 1.1))
    }))
    #align(center, text(size: 9pt)[*Möbius band*: ends glued after a half turn — edges 1 and 2 join into one circle, so $E$ is not $S^1 times I$.])
  ],
)

#v(4pt)

- Over a short arc of the base both are the same rectangle $U times I$: same base $S^1$, same fiber the interval $I$, and *both satisfy local triviality*.
- Only the identification of the two ends differs — and that one choice decides whether a global product structure exists at all.
- A bundle is therefore the *map* $pi$, not the space $E$: one base with one fiber can be bundled in genuinely different ways.

#v(4pt)

#alert[*Take away:* “fiber bundle” is a local condition, and the twist — invisible patch by patch — is the real content.]

== Fiber bundles are everywhere once you have the word for them

#set text(size: 9.5pt)

#table(
  columns: (auto, auto, auto, 1fr),
  align: (left, left, left, left),
  inset: (x: 4.5pt, y: 3.4pt),
  stroke: none,
  table.hline(stroke: 1.1pt + green),
  table.header([*Bundle*], [*Base*], [*Fiber*], [*What the fiber holds*]),
  table.hline(stroke: 0.6pt + band),
  [$RR -> S^1$], [$S^1$], [$ZZ$, discrete], [A lift of a loop records how often it winds around],
  [$T M -> M$], [a manifold $M$], [$RR^n$], [A section is a vector field: a velocity at every point],
  [Möbius band], [$S^1$], [an interval $I$], [One long edge instead of two: the simplest twist],
  [$S^3 -> S^2$], [$S^2$], [$S^1$], [The Hopf fibration: the 3-sphere, filled by linked circles],
  table.hline(stroke: 1.1pt + green),
)

#v(5pt)

- *Sections*: a single point chosen in every fiber. Vector fields are the sections of $T M -> M$, and $S^2$ admits no nowhere-zero vector field: a bundle can forbid a choice that looks locally easy.
- *Gluing data*: comparing neighbouring patches gives transition functions with values in a group, and they classify the bundles over a fixed base and fiber.
- *Physics*: a gauge field is a connection on a bundle whose fiber is the internal symmetry space — the twist is what the field measures.
