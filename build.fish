#!/usr/bin/env fish
# Build the site locally. Run this before every `git push`.

set -l typst_flags --features html --format html --root .
set -l pandoc_flags --template=template.html --mathml --syntax-highlighting=monochrome --citeproc

for src in posts/*.typ
    set -l out (string replace -r '\.typ$' '.html' $src)
    echo "typst   $src"
    typst compile $typst_flags $src $out
end

for src in posts/*.md
    set -l out (string replace -r '\.md$' '.html' $src)
    echo "pandoc  $src"
    pandoc $src -o $out $pandoc_flags --variable root=../
end

echo "typst   cv.typ"
typst compile cv.typ cv.pdf

python3 build_index.py >_index.md
for page in _index.md=index.html about.md=about.html dvorak.md=dvorak.html bitcoin.md=bitcoin.html 404.md=404.html
    set -l src (string split -m1 = $page)[1]
    set -l out (string split -m1 = $page)[2]
    echo "pandoc  $src"
    pandoc $src -o $out $pandoc_flags --variable root=./
end

echo "Built."
