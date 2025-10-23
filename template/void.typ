
#let deep-red = rgb(182, 49, 28)


#let slides-prologue(title, subtitle, author, date: none, background-image: none, use-cover-logo: false, logo-image: none) = {
  page(margin: (top: 10%, bottom: 10%, left: 5%, right: 5%), background: background-image, header: if use-cover-logo {
    align(right, logo-image)
  })[
    #{
      if title != none {
        align(center + horizon, text(25pt, weight: "bold", title))
      }
      if subtitle != none {
        align(center + horizon, text(18pt, weight: "regular", fill: gray, subtitle))
      }
      if author != none {
        align(center + horizon, text(17pt, weight: "regular", author))
      }
      if date != none {
        align(right + bottom, text(15pt, date))
      }
    }
  ]
}

#let slides-catalogue(outline-text, heading-font, outline-bgcolor) = {
  set page(margin: (top: 0%, bottom: 0%, left: 0%, right: 0%))
  set outline(title: none, depth: 2, indent: 2em)
  show outline.entry.where(level: 1): it => {
    v(30pt, weak: true)
    text(fill: outline-bgcolor.lighten(10%), size: 20pt, font: heading-font, weight: "bold", it)
  }
  show outline.entry.where(level: 2):it => {
    text(fill: outline-bgcolor.lighten(20%), size: 15pt, font: heading-font, weight: "regular", it)
  }
  grid(
    columns: (30%, 50%),
    column-gutter: 10%,
    align(
      center + horizon,
      box(fill: outline-bgcolor, width: 100%, height: 100%, text(fill: white, size: 40pt, hyphenate: true, outline-text)),
    ),
    align(center + horizon, outline()),
  )
}

#let slides-episodes(
  body,
  episode-font,
  subsection-prefix,
  use-title-line: false,
  outline-bgcolor,
  content-title-color,
  title-line-color,
  chapter-bgcolor,
) = {
  set page(margin: (top: 20%, bottom: 5%, left: 5%, right: 5%), header: context {
    let loc = here();
    let elem = heading.where(level: 1).before(loc)
    let title = query(elem).last().body
    grid(
      rows: (70%, 10%),
      row-gutter: 0%,
      // content title
      grid(align(right + horizon, text(fill: content-title-color, size: 25pt, font: episode-font, title))),
      if use-title-line {
        align(center + bottom, line(length: 100%, stroke: (paint: title-line-color, thickness: 2pt)))
      },
    )
  })

  show heading.where(level: 1): it => {
    set page(margin: (top: 5%, bottom: 5%, left: 5%, right: 5%), fill: chapter-bgcolor, header: none, background: none)
    align(center + horizon, text(fill: white, size: 40pt, font: episode-font, it))
  }

  show heading.where(level: 2): it => context {
    let loc = here();
    let level_1_now_title = query(heading.where(level: 1).before(loc)).last().body
    let level_2_now_title = query(heading.where(level: 2).before(loc)).last().body

    let first_title = none
    let get = false
    for item in query(heading.where(level: 1).or(heading.where(level: 2))) {
      if get {
        if item.level == 2 {
          first_title = item.body
        }
        break
      } else {
        if item.level == 1 and item.body == level_1_now_title {
          get = true
        }
      }
    }

    if first_title != level_2_now_title {
      pagebreak()
    }

    align(top, text(size: 20pt, font: episode-font, subsection-prefix + it.body))
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
  title: none,
  subtitle: none,
  author: none,
  heading-font-serif: ("FandolHei"),
  text-font-serif: ("New Computer Modern", "FandolSong"),
  heading-font-sans: ("Inria Sans", "PingFang SC"),
  text-font-sans: ("Inria Sans", "PingFang SC"),
  sans: true,
  date: datetime.today().display("時 [year] 年 [month] 月 [day] 日"),
  body,
  outline-text: [*Outline*],
  end-text: align(center)[*Thanks!*],
  subsection-prefix: [#math.section ],
  use-title-line: false,
  outline-bgcolor: deep-red,
  content-title-color: deep-red,
  title-line-color: deep-red,
  chapter-bgcolor: deep-red,
  epilogue-bgcolor: deep-red,
  monochrome: false,
  theme-color: deep-red,
) = {
  let heading-font = if sans {
    heading-font-sans
  } else {
    heading-font-serif
  }

  let text-font = if sans {
    text-font-sans
  } else {
    text-font-serif
  }

  if monochrome {
    outline-bgcolor = theme-color;
    content-title-color = theme-color;
    title-line-color = theme-color;
    chapter-bgcolor = theme-color;
    epilogue-bgcolor = theme-color;
  }

  show heading: set text(font: heading-font, weight: "regular")
  set page(paper: "presentation-16-9")
  set text(font: text-font, size: 18pt, weight: "regular")

  slides-prologue(title, subtitle, author, date: date)
  slides-catalogue(outline-text, heading-font, outline-bgcolor)
  slides-episodes(
    body,
    heading-font,
    subsection-prefix,
    outline-bgcolor,
    content-title-color,
    title-line-color,
    chapter-bgcolor,
    use-title-line: use-title-line,
  )
  slides-epilogue(end-text, epilogue-bgcolor)
}


