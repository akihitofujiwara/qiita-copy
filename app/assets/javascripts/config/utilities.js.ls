# Simple Flux
Flux =
  states: states = {}
  tasks: tasks = []
  add: -> tasks := tasks ++ it
  render: render = -> tasks |> map (apply _, [states])
  store: (k, v)--> states.(k) = v; render!

