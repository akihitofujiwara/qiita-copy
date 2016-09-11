$ document .on "mouseenter mouseleave", ".follow-link", ->
  $ @ .find "a > span" .toggle-class \active
  $a.data \toggle-class |> (or "") |> split " " |> compact |> each ($a = $ @ .find \a)~toggle-class


