
#import "scheme.typ": builtin, monochrome

#let slides-catalogue(outline-text, heading-font, outline-bgcolor) = {
  set page(margin: (top: 0%, bottom: 0%, left: 0%, right: 0%))
  set outline(title: none, depth: 2, indent: 2em)
  show outline.entry.where(level: 1): it => {
    v(30pt, weak: true)
    text(fill: outline-bgcolor.lighten(10%), size: 20pt, font: heading-font, weight: "bold", it)
  }
  show outline.entry.where(level: 2): it => {
    text(fill: outline-bgcolor.lighten(20%), size: 15pt, font: heading-font, weight: "regular", it)
  }

  grid(
    columns: (30%, 50%),
    column-gutter: 10%,
    align(
      center + horizon,
      box(fill: outline-bgcolor, width: 100%, height: 100%, text(
        fill: white,
        size: 40pt,
        hyphenate: true,
        outline-text,
      )),
    ),
    align(center + horizon, outline()),
  )
}

// content page
#let slides-episodes(
  body,
  episode-font,
  text-font-sans,
  subsection-prefix,
  display-title-line: false,
  outline-bgcolor,
  content-title-color,
  title-line-color,
  chapter-bgcolor,
  display-page-counter: true,
  page-counter: () => [#counter(page).display() ~/~ #counter(page).final().at(0)],
) = {
  set page(
    margin: (top: 20%, bottom: 5%, left: 5%, right: 5%),
    header: context {
      let loc = here()
      let elem = heading.where(level: 1).before(loc)
      let title = query(elem).last().body
      grid(
        rows: (70%, 10%),
        row-gutter: 0%,
        // content title
        grid(align(right + horizon, text(fill: content-title-color, size: 25pt, font: episode-font, title))),
        if display-title-line {
          align(center + bottom, line(length: 100%, stroke: (paint: title-line-color, thickness: 2pt)))
        },
      )
    },
    footer: context {
      if display-page-counter {
        place(right, dx: 5%, page-counter())
      }
    },
  )

  show heading.where(level: 1): it => {
    set page(
      margin: (top: 5%, bottom: 5%, left: 5%, right: 5%),
      fill: chapter-bgcolor,
      header: none,
      background: none,
      footer: none,
    )
    align(center + horizon, text(fill: white, size: 40pt, font: episode-font, it))
  }

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

    align(top, text(size: 20pt, font: episode-font, subsection-prefix + " " + it.body))
    v(1em)
  }
  body
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
  prologue: builtin.prologue.simple,

  outline-text: [*Outline*],
  end-text: align(center)[*Thanks!*],
  subsection-prefix: [#math.section],
  display-title-line: false,

  color-scheme: monochrome(builtin.colors.deep-red-1),
  font-scheme: builtin.font.sans,
  paper: "presentation-16-9",
  body,
) = {
  set page(paper: paper)
  show heading: set text(font: font-scheme.heading-font, weight: "regular")
  show math.equation: set text(font: font-scheme.math-font)
  set text(font: font-scheme.text-font, size: 18pt, weight: "regular")

  prologue(title: title, subtitle: subtitle, author: author, date: date)
  slides-catalogue(outline-text, font-scheme.heading-font, color-scheme.outline-bg)
  counter(page).update(1)

  slides-episodes(
    body,
    font-scheme.heading-font,
    font-scheme.text-font,
    subsection-prefix,
    color-scheme.outline-bg,
    color-scheme.content-title,
    color-scheme.title-line,
    color-scheme.chapter-bg,
    display-title-line: display-title-line,
  )
  slides-epilogue(end-text, color-scheme.epilogue-bg)
}
