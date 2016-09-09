$ document .on \click, "body.items.draft .sidebar .item", ->
  $ ".sidebar .item, .preview" .remove-class \active
  [@, ".preview[data-id=#{$ @ .data \id}]"] |> each $ >> ( .add-class \active)

