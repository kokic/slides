// EastLansing + spruce, a standalone Typst theme (no package dependencies).
// Usage from another file:
//   #import "east-lansing.typ": east-lansing, panel, subtitle, alert
//   #show: east-lansing.with(title: [My talk], author: [Author])
//   = Introduction
//   == First slide
//   - A point
//   #panel[Remark][A short explanation.]
//   == Second slide #subtitle[Optional subtitle]
//   $ a^2 + b^2 = c^2 $
//
// = Section: updates the left headline, without creating a section slide.
// == Slide: starts a page, supplies its title and the right headline.
// === and deeper: ordinary headings inside a slide.
// Write slide content after a == heading. A cover is generated automatically;
// cover: false omits it. The cover is included in the page count.
// centered: false top-aligns slide bodies. Long slides must be split manually;
// an automatic overflow page repeats the headline, but not the frame title.
// width: 160mm, height: 90mm selects 16:9 (default: Beamer's 128 × 96mm).
// footline: false hides the static footer. No PDF navigation actions are added.
// Use short-title / short-author / short-date when footer text would be too long.
// For closer TeX typography, install Latin Modern Sans and set font accordingly.
// List layout can be customized with list-style: (spacing: 0.6em, ...).
// See default-list-style below for all defaults. sizes accepts em or pt values;
// (1em,) keeps every nesting level at the surrounding text size.
// Native #set list(marker: ...) / #set enum(numbering: ...) remain available.
// See ../examples/east-lansing.typ for a complete presentation.
//
// Based on Beamer's EastLansing, spruce and infolines definitions:
// https://github.com/josephwright/beamer/tree/main/base/themes
// This variant uses green structure text, flat panels and square list markers.

#let spruce = (
  green: rgb("006633"),
  structure: rgb("005229"),
  title-bg: rgb("d9e8e0"),
  frame-bg: rgb("e6f0eb"),
  primary-fg: rgb("003d1f"),
  secondary-bg: rgb("99c2ad"),
  secondary-fg: rgb("004724"),
  tertiary-bg: rgb("005229"),
  tertiary-fg: rgb("80b399"),
  alert: rgb("33855c"),
  example: rgb("008000"),
)

#let panel(title, body, kind: "normal") = {
  let title-fill = (normal: spruce.tertiary-bg, alert: spruce.alert, example: spruce.example).at(kind)
  // Flat, contiguous title/body panels in the spruce green palette.
  block(width: 100%, breakable: false, above: 0.6em, below: 0.6em,
    stack(dir: ttb, spacing: 0pt,
      if title != none {
        block(width: 100%, fill: title-fill, inset: (x: 4pt, y: 3pt),
          text(size: 12pt, fill: white, title),
        )
      },
      block(width: 100%, fill: spruce.frame-bg, inset: (x: 4pt, y: 5pt),
        text(fill: black, body),
      ),
    ),
  )
}

#let alert(body) = text(fill: spruce.alert, body)

// Place inline at the end of a == heading.
#let subtitle(body) = metadata((east-lansing-subtitle: body))

// Sizes are relative to the font at the outermost list, not to the previous
// level. Deeper levels reuse the last size. Both list types share this style.
// Override only the fields you need via east-lansing.with(list-style: (...)).
#let default-list-style = (
  sizes: (1em, 0.96em, 0.92em),
  leading: 0.55em, // line spacing inside a wrapped item
  spacing: 0.45em, // spacing between sibling items
  above: 0.6em,
  below: 0.6em,
  nested-above: 0.35em,
  nested-below: 0.2em,
  indent: 1em,
  body-indent: 0.6em,
  marker-size: 0.44em,
  number-box-size: 0.95em,
  number-size: 0.8em,
  marker-fill: auto, // auto follows the theme's structure color.
  number-fill: white,
  marker-shift: 0pt, // positive values move the marker down.
)

#let east-lansing(
  title: [Presentation Title],
  subtitle: none,
  author: [],
  institute: none,
  date: [],
  short-title: auto,
  short-author: auto,
  short-institute: none,
  short-date: auto,
  width: 128mm,
  height: 96mm,
  font: ("Helvetica", "Heiti SC"),
  math-font: "New Computer Modern Math",
  size: 11pt,
  structure: spruce.structure,
  list-style: (:),
  cover: true,
  centered: true,
  headline: true,
  footline: true,
  body,
) = {
  let list-style = (: ..default-list-style, ..list-style)
  let head-height = if headline { 11pt } else { 0pt }
  let foot-height = if footline { 8.7pt } else { 0pt }
  let short-title = if short-title == auto { title } else { short-title }
  let short-author = if short-author == auto { author } else { short-author }
  let short-date = if short-date == auto { date } else { short-date }

  let square-marker(body: none, side: list-style.marker-size) = context {
    // Align the marker's center with the current font's capital-letter center.
    // Use an explicit baseline: empty shapes and numbered boxes otherwise
    // inherit different baselines from their contents.
    let cap-height = measure(text(top-edge: "cap-height", bottom-edge: "baseline")[H]).height
    box(
      width: side,
      height: side,
      baseline: (at: horizon, shift: -cap-height / 2 + list-style.marker-shift),
      fill: if list-style.marker-fill == auto { structure } else { list-style.marker-fill },
      inset: 0pt,
      if body != none {
        align(center + horizon, text(
          fill: list-style.number-fill, size: list-style.number-size,
          top-edge: "cap-height", bottom-edge: "baseline", body,
        ))
      },
    )
  }

  set document(title: title)
  set text(font: font, size: size, fill: black, weight: "regular", lang: "en")
  set par(leading: 0.5em, spacing: 0.65em, justify: false)
  set block(above: 0pt, below: 0pt)
  set list(
    marker: square-marker(),
    indent: list-style.indent,
    body-indent: list-style.body-indent,
    spacing: list-style.spacing,
  )
  set enum(
    numbering: n => square-marker(body: str(n), side: list-style.number-box-size),
    indent: list-style.indent,
    body-indent: list-style.body-indent,
    spacing: list-style.spacing,
  )
  let render-list(it, depth: 0, sizes: none) = if it.has("label") and it.label == <east-lansing-styled-list> {
    it
  } else {
    context {
      let sizes = if sizes == none { list-style.sizes.map(s => s.to-absolute()) } else { sizes }
      set text(size: sizes.at(calc.min(depth, sizes.len() - 1)))
      set par(leading: list-style.leading)
      // Apply nested styling only inside item bodies. Installing a nested show
      // rule around the whole list would also restyle its own root element.
      show list: set block(above: 0pt, below: 0pt)
      show enum: set block(above: 0pt, below: 0pt)
      let fields = it.fields()
      // The original element retains its user label; it is not a constructor arg.
      let _ = fields.remove("label", default: none)
      let items = fields.remove("children").map(item => {
        let item-fields = item.fields()
        let original-body = item-fields.remove("body")
        let body = {
          show list: nested => render-list(nested, depth: depth + 1, sizes: sizes)
          show enum: nested => render-list(nested, depth: depth + 1, sizes: sizes)
          original-body
        }
        if item.func() == enum.item {
          enum.item(item-fields.remove("number", default: auto), ..item-fields, body)
        } else {
          list.item(..item-fields, body)
        }
      })
      block(
        above: if depth == 0 { list-style.above } else { list-style.nested-above },
        below: if depth == 0 { list-style.below } else { list-style.nested-below },
        [#(it.func())(..fields, ..items) <east-lansing-styled-list>],
      )
    }
  }
  show list: render-list
  show enum: render-list
  show math.equation: set text(font: math-font)
  show math.equation.where(block: true): set block(above: 0.7em, below: 0.7em)
  show heading: set text(fill: structure, weight: "regular")

  let strip-cell(body, bg, fg, height, alignment) = block(
    width: 100%, height: height, fill: bg, inset: (x: 5pt),
    align(alignment + horizon, text(size: 6pt, fill: fg, body)),
  )

  let chrome(section, subsection) = {
    if headline {
      place(top + left, grid(columns: (1fr, 1fr), gutter: 0pt,
        strip-cell(section, spruce.tertiary-bg, spruce.tertiary-fg, head-height, right),
        strip-cell(subsection, spruce.title-bg, spruce.primary-fg, head-height, left),
      ))
    }
    if footline {
      place(bottom + left, grid(columns: (1fr, 1fr, 1fr), gutter: 0pt,
        strip-cell(
          [#short-author#if short-institute != none { [#h(0.6em) (#short-institute)] }],
          spruce.tertiary-bg, spruce.tertiary-fg, foot-height, center,
        ),
        strip-cell(short-title, spruce.secondary-bg, spruce.secondary-fg, foot-height, center),
        strip-cell(
          context [#h(1fr)#short-date#h(1fr)#counter(page).display() / #counter(page).final().first()],
          spruce.title-bg, spruce.primary-fg, foot-height, left,
        ),
      ))
    }
  }

  // Resolve navigation from the slide heading, so a section declared between
  // slides cannot change the headline of the preceding slide.
  let navigation = context {
    let current-page = counter(page).get().first()
    let slides = query(heading.where(level: 2, outlined: true)).filter(h =>
      counter(page).at(h.location()).first() <= current-page
    )
    if slides.len() == 0 {
      chrome([], [])
    } else {
      let current = slides.last()
      let sections = query(heading.where(level: 1).before(current.location()))
      chrome(if sections.len() == 0 { [] } else { sections.last().body }, current.body)
    }
  }

  set page(
    width: width, height: height, fill: white,
    margin: (x: size, top: head-height, bottom: foot-height + 8pt),
    header: none, footer: none, numbering: none,
    background: navigation,
  )
  set heading(numbering: none, outlined: false, bookmarked: false)
  show heading.where(level: 2): set text(size: 14.4pt)
  show heading.where(level: 2): set block(above: 0pt, below: 0pt)
  show heading.where(level: 1): _ => []
  show heading.where(level: 2, outlined: false): it => context {
    let previous = query(heading.where(level: 2, outlined: false).before(it.location(), inclusive: false))
    if previous.len() > 0 {
      if centered { v(1fr) }
      pagebreak(weak: true)
    }
    block(
      width: 100%, fill: spruce.frame-bg, outset: (x: size),
      inset: (x: 8.5pt - size, y: 6pt), above: 0pt, below: 8pt,
      {
        show metadata: item => {
          if type(item.value) == dictionary and "east-lansing-subtitle" in item.value {
            linebreak()
            text(size: 9.5pt, item.value.east-lansing-subtitle)
          }
        }
        // Emit the bookmark at the visible title, after the page break.
        heading(level: 2, outlined: true, bookmarked: true, it.body)
      },
    )
    if centered { v(1fr) }
  }

  if cover {
    page(
      width: width, height: height, margin: (x: size, top: head-height + 8pt, bottom: foot-height + 8pt),
      background: chrome([], []),
      align(center + horizon)[
        #set align(center)
        #block(
          width: 100%, radius: 0pt, fill: spruce.title-bg,
          inset: (x: 8pt, y: 8pt), outset: (x: 4pt),
        )[
          #text(size: 14.4pt, fill: spruce.primary-fg, title)
          #if subtitle != none {
            block(above: 5pt, text(size: 11pt, fill: spruce.primary-fg, subtitle))
          }
        ]
        #v(16pt)
        #author
        #if institute != none {
          block(above: 12pt, text(size: 8pt, institute))
        }
        #block(above: 16pt, date)
      ],
    )
  }
  body
  if centered { v(1fr) }
}
