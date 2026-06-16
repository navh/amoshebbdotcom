# Authoring

## New Typst post

Create `posts/my-post-title.typ`:

```typst
#import "/template.typ": post
#let info = (title: "Post Title", date: "2026-06-16", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

Content here, with $math$, footnotes #footnote[...], and @citations.

#bibliography("refs.bib", style: "ieee") // if cited; labels are alphanumeric by default
```

Math, footnotes, and citations all come from Typst's native HTML export — no Markdown,
no Pandoc, for new posts.

## New Markdown post (legacy path, still supported)

Create `posts/my-post-title.md`:

```markdown
---
title: "Post Title"
date: 2026-06-04
tags: ["radar"]
---

Content here.
```

## Build and preview

```bash
cd ~/amoshebb.com
fish build.fish
python3 -m http.server 8080 --bind 0.0.0.0
```

`build.fish` compiles `.typ` posts with `typst`, `.md` posts with `pandoc`, regenerates
`_index.md`/`index.html`, and rebuilds `about.html`, `dvorak.html`, `bitcoin.html`.
Run it before every commit — the built HTML is committed to the repo and GitHub Pages
serves it directly, there is no CI build step.

Access the preview from a laptop via SSH port forward:
```
ssh -L 8080:localhost:8080 <your normal ssh command>
```
Then open `http://localhost:8080`.

## Deploying

```bash
fish build.fish
git add .
git commit -m "..."
git push
```

GitHub Pages is set to deploy from the `main` branch root — pushing is the deploy.
