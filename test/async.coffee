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