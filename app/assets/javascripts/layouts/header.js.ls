do ->
  {add, store} = Flux

  add ({others = [], user = [], tag = []}:states)->
    return if ($ ":focus" .0) in ($input = $ ".search [type=search]")
    $input.val (
      [others, (user |> map (\user: +)), (tag |> map (\tag: +))]
      |> concat
      |> join " "
    )

  add (states)->
    <[user tag]> |> each ->
      return if ($input = $ ".search input[data-type=#it]").0 is ($ ":focus").0
      $input.val (states.(it) |> (or []) |> join " ")

  $ document .on \keyup, ".search input[type=search]", ->
    $ @ .val!
    |> split /\s+/
    |> compact
    |> map ( .match /((\S+):)?(\S+)/)
    |> group-by ( .2) >> (or \others)
    |> obj-to-pairs
    |> each ([key, matches])->
      store key, (matches |> map ( .3))

  $ document .on \keyup, ".search input.support", ->
    $ @ .val!
    |> split /\s+/
    |> compact
    |> store ($ @ .data \type)

  $ document .on \ready, ->
    $ ".search [type=search]" .val (
      (new URLSearchParams(location.search)).get("q")
    ) .trigger \keyup

