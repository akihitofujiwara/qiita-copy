do ->
  main = ->
    listen! if <[home not-signed-in]> |> all (in classes \body)

  classes = $ >> head >> ( .class-list)

  listen = ->
    $ ".login .mail a" .on \click, -> activate \signup
    $ ".signup a" .on \click, -> activate \login

  activate = ->
    $ ".login, .signup" .remove-class \active
    $ ".#it" .add-class \active

  $ main

