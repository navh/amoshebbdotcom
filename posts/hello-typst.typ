#import "/template.typ": post
#let info = (title: "Authoring with Typst", date: "2026-06-16", tags: ("meta",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

This post is compiled straight from Typst source to HTML, no Markdown or Pandoc involved.
Inline math like $E = m c^2$ and display equations both come out as real MathML, not images.

$ integral_0^infinity e^(-x) dif x = 1 $

Footnotes work the way you'd expect from Typst.#footnote[Including backlinks, rendered by Typst itself.]

Citations work too, pulling from a plain `.bib` file @shannon1948.

#bibliography("refs.bib", style: "ieee")
