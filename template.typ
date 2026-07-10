// Shared HTML chrome for Typst-authored posts.
// Usage in a post:
//
//   #import "/template.typ": post
//   #let info = (title: "Post Title", date: "2026-06-16", tags: ("radar",))
//   #metadata(info) <frontmatter>
//   #show: body => post(info: info, body)
//
//   Content here, with $math$, footnotes #footnote[...], and @citations.
//   #bibliography("refs.bib", style: "ieee") // if cited; inline labels are alphanumeric by default

#let post(info: (:), body) = {
  set document(title: info.title + " — Amos Hebb")
  set cite(style: "alphanumeric")
  html.elem("link", attrs: (rel: "stylesheet", href: "/style.css"))
  html.elem("link", attrs: (rel: "icon", href: "/favicon.ico"))
  html.elem("nav", html.elem("a", attrs: (href: "/index.html"), "Amos Hebb"))
  html.elem("h1", info.title)
  if "date" in info {
    html.elem("p", attrs: (class: "date"), info.date)
  }
  body
  html.elem("footer", html.elem("a", attrs: (href: "/index.html"), [← index]))
}
