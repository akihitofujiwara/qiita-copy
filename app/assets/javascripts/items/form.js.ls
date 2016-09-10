$ document .on \keyup, "body.items textarea", $.debounce 200, ->
  $.post \/md2html, md: ($ @ .val!),
    ( .html) >> $ ".preview .content" .html _

$ document .on \click, "body.items .dropup .dropdown-menu li", ->
  $ "body.items form input[name=\"item[scope]\"]" .val ($ @ .data \scope)
  $ @
    ..parent!.children!.remove-class \selected
    ..add-class \selected
  $ @ .parent!.siblings \button .find \span
    ..remove-class \selected
    ..filter "[data-scope=#{$ @ .data \scope}]" .add-class \selected
