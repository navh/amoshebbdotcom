#!/usr/bin/env python3
import glob, json, re, subprocess

posts = []
for path in sorted(glob.glob("posts/*.md")):
    text = open(path).read()
    m = re.match(r'^---\n(.*?)\n---', text, re.DOTALL)
    if not m:
        continue
    fm = m.group(1)
    title = re.search(r'^title:\s*"?(.*?)"?\s*$', fm, re.M)
    date  = re.search(r'^date:\s*(\d{4}-\d{2}-\d{2})', fm, re.M)
    if not title or not date:
        continue
    slug = re.sub(r'\.md$', '', re.sub(r'^posts/', '', path))
    posts.append((date.group(1), title.group(1), slug))

for path in sorted(glob.glob("posts/*.typ")):
    result = subprocess.run(
        ["typst", "eval", "--features", "html", "--target", "html",
         "--root", ".", "--in", path,
         "query(<frontmatter>).map(it => it.value).first()"],
        capture_output=True, text=True,
    )
    if result.returncode != 0:
        continue
    info = json.loads(result.stdout)
    slug = re.sub(r'\.typ$', '', re.sub(r'^posts/', '', path))
    posts.append((info["date"], info["title"], slug))

posts.sort(reverse=True)

print("---")
print("title: Amos Hebb")
print("---")
print()
print("[about](about.html)")
print()
print("---")
print()
for date, title, slug in posts:
    print(f"- {date} — [{title}](posts/{slug}.html)")
