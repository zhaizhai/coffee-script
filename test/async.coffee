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
