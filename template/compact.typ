
#import "scheme.typ": builtin, monochrome

// #let slides-catalogue(outline-text, heading-font, outline-bgcolor) = {
//   set page(margin: (top: 0%, bottom: 0%, left: 0%, right: 0%))
//   set outline(title: none, depth: 2, indent: 2em)

//   let outline-font-size = (
//     lv1: 25pt,
//     lv2: 20pt,
//   )
//   show outline.entry.where(level: 1): it => {
//     v(30pt, weak: true)
//     text(fill: outline-bgcolor.lighten(10%), size: outline-font-size.lv1, font: heading-font, weight: "bold", it)
//   }
//   show outline.entry.where(level: 2): it => {
//     text(fill: outline-bgcolor.lighten(20%), size: outline-font-size.lv2, font: heading-font, weight: "regular", it)
//   }
  
//   grid(
//     columns: (30%, 50%),
//     column-gutter: 10%,
//     align(
//       center + horizon,
//       box(fill: outline-bgcolor, width: 100%, height: 100%, text(
//         fill: white,
//         size: 40pt,
//         hyphenate: true,
//         outline-text,
//       )),
//     ),
//     align(center + horizon, outline()),
//   )
// }

#let slides-section-tabs() = context {
  let sections = ()
  let level1-headings = query(heading.where(level: 1))
  let current-page = counter(page).at(here()).at(0)
  let episode-end = query(<slides-episodes-end>)
  let final-page = if episode-end.len() > 0 {
    counter(page).at(episode-end.last().location()).at(0)
  } else {
    counter(page).final().at(0)
  }

  let i = 0
  while i < level1-headings.len() {
    let item = level1-headings.at(i)
    let start-page = counter(page).at(item.location()).at(0)
    let end-page = if i + 1 < level1-headings.len() {
      counter(page).at(level1-headings.at(i + 1).location()).at(0) - 1
    } else {
      final-page
    }

    let page-count = end-page - start-page + 1
    if page-count < 1 {
      page-count = 1
    }

    sections.push((title: item.body, start-page: start-page, page-count: page-count))
    i += 1
  }

  let columns = ()
  let cells = ()

  for section in sections {
    columns.push(1fr)
    cells.push(box(fill: builtin.colors.deep-red-2, width: 100%, inset: (x: 1em, y: 0.5em), text(
      fill: white,
      size: 16pt,
    )[
      #block(above: 0em, below: 0.3em, text(font: "Alegreya Sans SC", section.title))
      #{
        let i = 0
        while i < section.page-count {
          if section.start-page + i == current-page {
            box(inset: (x: 2pt), circle(radius: 3pt, stroke: white, fill: white))
          } else {
            box(inset: (x: 2pt), circle(radius: 3pt, stroke: white))
          }
          i = i + 1
        }
      }
    ]))
  }

  if cells.len() > 0 {
    grid(columns: columns, ..cells)
  }
}

// content page
#let slides-episodes(
  body,
  font-scheme,
  subsection-prefix,
  outline-bgcolor,
  content-title-color,
  title-line-color,
  chapter-bgcolor,
  display-page-counter: true,
  page-counter: () => [#counter(page).display() ~/~ #counter(page).final().at(0)],
) = {
  let margin-x = 2em
  set page(
    margin: (left: margin-x, right: margin-x),
    header: context {
      place(left, dx: -margin-x, box(width: 100% + margin-x * 2, slides-section-tabs()))
    },
    footer: context {
      if display-page-counter {
        place(right, dx: margin-x, page-counter() + [#h(1em)])
      }
    },
  )

  // hidden
  show heading.where(level: 1): it => {}

  show heading.where(level: 2): it => context {
    let loc = here()
    let level1-now-title = query(heading.where(level: 1).before(loc)).last().body
    let level2-now-title = query(heading.where(level: 2).before(loc)).last().body

    let first-title = none
    let get = false
    for item in query(heading.where(level: 1).or(heading.where(level: 2))) {
      if get {
        if item.level == 2 {
          first-title = item.body
        }
        break
      } else {
        if item.level == 1 and item.body == level1-now-title {
          get = true
        }
      }
    }

    if first-title != level2-now-title {
      pagebreak()
    }

    block(width: 100%, inset: (x: -1em), below: 1em, text(
      size: 25pt,
      weight: font-scheme.heading-weight,
      font: font-scheme.heading-font,
      subsection-prefix + " " + it.body,
    ))
  }
  body
  [#metadata(none) <slides-episodes-end>]
}


#let slides-epilogue(end-text, epilogue-bgcolor) = {
  set page(fill: epilogue-bgcolor)
  set align(left + horizon)
  text(40pt, fill: white)[#end-text]
}

#let beamer(
  title: [Presentation Title],
  subtitle: [I believe what you said],
  author: [Hydrangea Kokic],
  date: datetime.today().display("時 [year] 年 [month] 月 [day] 日"),
  prologue: builtin.prologue.invert,
  outline-text: [*Outline*],
  end-text: align(center)[*Thanks!*],
  subsection-prefix: [#math.section],
  color-scheme: monochrome(builtin.colors.deep-red-1),
  font-scheme: builtin.font.sans,
  paper: "presentation-16-9",
  body,
) = {
  set page(paper: paper)
  show heading: set text(font: font-scheme.heading-font, weight: font-scheme.heading-weight)
  show math.equation: set text(font: font-scheme.math-font)
  // 18pt
  set text(font: font-scheme.text-font, weight: "light")

  prologue(title: title, subtitle: subtitle, author: author, date: date)
  // slides-catalogue(outline-text, font-scheme.heading-font, color-scheme.outline-bg)
  counter(page).update(1)

  slides-episodes(
    body,
    font-scheme,
    subsection-prefix,
    color-scheme.outline-bg,
    color-scheme.content-title,
    color-scheme.title-line,
    color-scheme.chapter-bg,
  )
  slides-epilogue(end-text, color-scheme.epilogue-bg)
}
