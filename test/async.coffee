# Async function syntax
# -------------------

# * Async function syntax

# TODO: we might need an async test framework to test this all
# properly
test "Basic async", ->
  f = (x) ~>
    callback 2 * x
  y =< f 5
  eq y, 10

test "Nested async functions", ->
  f = ~>
    g = ~>
      callback 5
    callback g

  _g =< f()
  x =< _g()
  eq x, 5

test "Backcall and async", ->
  g = (x, cb) ->
    return cb (x + 3)

  f = (x) ~>
    y =< g x
    callback (y + 2)

  z =< f 3, (x) -> x
  eq z, 8

# # TODO: we can't test this yet w/o an async framework
# test "Async with backcall and implicit callback", ->
#   g = (x) ~>

#   f = (x) ~>
#     =< g x

#   =< f 3
#   # TODO: test that it got here

test "Nested backcalls", ->
  g = (x, cb) ->
    return cb (x + 3)

  f = (x) ~>
    y =< g x
    z =< g y
    callback (z + 2)

  z =< f 3, (x) -> x
  eq z, 11

test "Nested backcalls and async functions", ->
  g = (x, cb) ->
    return cb (x + 3)

  f = (x) ~>
    h = ~>
      y =< g x
      z =< g y
      callback z
    callback h

  _g =< f 2
  x =< _g()
  eq x, 8