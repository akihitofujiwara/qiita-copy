$ document .on "mouseenter mouseleave", "[data-toggle=btn]", ->
  $ @ .find "> span" .toggle-class \active
  $ @ .data \toggle-class |> (or "") |> split " " |> compact |> each ($ @)~toggle-class

