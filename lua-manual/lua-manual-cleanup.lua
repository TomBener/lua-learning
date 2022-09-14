function Code (c)
  c.text = c.text:gsub('â‰¤', '<=')
  return c
end

function Emph (e)
  local s = e.content[1]
  if #e.content == 1 and s.tag == 'Str' and s.text == 'Ï€' then
    return pandoc.Math('InlineMath', 'Ï€')
  end
end

function Header (h)
  -- Unnumbered sections have the main contents as the first element.
  -- Numbered sections start with the number and an em-dash, so
  -- the Span is the fifth element (Lua multipass).
  local span
  if h.content[1].tag == 'Str' and h.content[1].text:match '[%d%.]+' then
    span = h.content[5]
  else
    span = h.content[1]
    h.classes:insert('unnumbered')
  end

  h.identifier = span.identifier
  h.content = span.content

  return h
end

function Pandoc (doc)
  -- comma separated authors
  local authors = doc.blocks[2]
  authors.content:remove(1)  -- remove 'by'
  doc.meta.author = pandoc.List()
  for author in pandoc.utils.stringify(authors):gmatch '[^,]+' do
    doc.meta.author:insert(author)
  end

  -- Remove unnecessary blocks
  doc.blocks:remove(4) -- menubar
  doc.blocks:remove(2) -- authors paragraph
  doc.blocks:remove(1) -- title header

  -- add subtitle image
  doc.meta.subtitle = pandoc.MetaInlines{
    pandoc.RawInline('latex', '\\vspace{1em}'),
    pandoc.Image("Lua logo", "https://www.lua.org/images/lua-logo.gif")
  }
  return doc
end
