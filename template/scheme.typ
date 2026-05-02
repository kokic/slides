
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
  heading-font,
  text-font,
  math-font: "New Computer Modern Math",
) => (
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
  ),
)
