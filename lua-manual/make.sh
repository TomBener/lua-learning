# https://tarleb.com/posts/pdf-of-the-lua-manual/
pandoc \
  --toc \
  --toc-depth=2 \
  --metadata=documentclass=report \
  --pdf-engine=xelatex \
  --variable mainfont=Palatino \
  --variable monofont=JetBrainsMono-Regular \
  --lua-filter=lua-manual-cleanup.lua \
  --number-sections \
  --top-level-division=chapter \
  --output=lua-5.4-manual.pdf \
  "https://lua.org/manual/5.4/manual.html"
