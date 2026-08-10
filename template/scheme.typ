
#let color-scheme = (
  outline-bg,
  content-title,
  title-line,
  chapter-bg,
  epilogue-bg,
) => (
  outline-bg: outline-bg,
  chapter-bg: chapter-bg,
  title-line: title-line,
  content-title: content-title,
  epilogue-bg: epilogue-bg,
)

#let monochrome = favor => {
  color-scheme(favor, favor, favor, favor, favor)
}

#let font-scheme = (
  heading-weight: "bold", 
  heading-font,
  text-font,
  math-font: "New Computer Modern Math",
) => (
  heading-weight: heading-weight,
  heading-font: heading-font,
  text-font: text-font,
  math-font: math-font,
)

#let prologue-simple = (
  title: none,
  subtitle: none,
  author: none,
  date: none,
  background-image: none,
  use-cover-logo: false,
  logo-image: none,
  fill-color: white,
) => {
  page(
    margin: (top: 10%, bottom: 10%, left: 5%, right: 5%),
    background: background-image,
    fill: fill-color,
    header: if use-cover-logo {
      align(right, logo-image)
    },
  )[
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

#let prologue-invert = (
  title: none,
  subtitle: none,
  author: none,
  date: none,
  institution: none,
  contact: none,
  background-image: none,
  use-cover-logo: false,
  logo-image: none,
  fill-color: rgb("#94060a"),
) => {
  page(
    margin: (top: 10%, bottom: 10%, left: 10%, right: 10%),
    background: background-image,
    fill: fill-color,
    header: if use-cover-logo { align(right, logo-image) },
    align(left + horizon, {
      set text(fill: white)
      if title != none {
        block(text(size: 40pt, font: "Alegreya Sans", weight: "black", title))
      }

      block(above: 40pt, below: 40pt, text(
        size: 24pt,
        font: "Alegreya",
        style: "italic",
        weight: "medium",
      )[#date \ #subtitle])

      block(text(size: 32pt, font: "Alegreya", weight: "bold", author))
      block(text(size: 24pt, font: "Alegreya", weight: "medium")[#institution \ #contact])
    }),
  )
}

#let builtin = (
  colors: (
    deep-red-1: rgb("#b6311c"),
    deep-red-2: rgb("#94060a"),
  ),
  font: (
    sans: font-scheme(
      ("Inria Sans", "PingFang SC"),
      ("Inria Sans", "PingFang SC"),
      math-font: "Lete Sans Math",
    ),
    serif: font-scheme(
      "FandolHei",
      ("New Computer Modern", "FandolSong"),
    ),
  ),
  prologue: (
    simple: prologue-simple,
    invert: prologue-invert,
  ),
)
