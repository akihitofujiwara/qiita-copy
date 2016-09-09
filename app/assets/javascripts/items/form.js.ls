$ document .on \keyup, "body.items textarea", $.debounce 200, ->
  $.post \/md2html, md: ($ @ .val!),
    ( .html) >> $ ".preview .content" .html _

