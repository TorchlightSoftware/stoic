# input/output filter
crypto = require 'crypto'

module.exports =
  input: (input, next) ->
    next null, crypto.createHash('md5').update(input).digest "hex"
  methods:
    compare: (password, next) ->
      check = crypto.createHash('md5').update(password).digest "hex"
      @get (hash) ->
        next null, hash is compare
