# Backcalls
# -------------------

# * Backcalls

# TODO: we might need an async test framework to test this all
# properly
test "Basic backcall", ->
  f = (x, cb) ->
    cb (x + 1)
  y =< f 5
  y =< f y
  eq y, 7

test "Multiple argument backcall", ->
  f = (cb) ->
    cb 1, 2, 3
  x, y, z =< f()
  eq x, 1
  eq y, 2
  eq z, 3

test "Nested backcalls", ->
  For = (range, to_run, cb) ->
    i = 0
    do_run = ->
      if i >= range.length
        return cb()
      to_run range[i], ->
        i++
        do_run()
    do_run()

  x = ''
  =< For [0...2], (i, cb) ->
    =< For [0...2], (j, cb) ->
      x += (2 * i + j)
      cb()
    cb()
  eq x, '0123'

test "Basic placeholders", ->
  f = (a, cb, b) ->
    cb (a + b)
  sum =< f 3, *, 5
  eq sum, 8

  throws -> CoffeeScript.compile "x =< f *, *"
  throws -> CoffeeScript.compile "x =< f *"