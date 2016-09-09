[".login .mail", ".signup a"] |> map ->
  $ document .on \click, "body.home.not-signed-in #it", ->
    $ ".login, .signup" .toggle-class \active


