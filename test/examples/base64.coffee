# input/output filter
module.exports =
  input: (input, next) ->
    next null, new Buffer(input).toString 'base64'
  output: (output, next) ->
    next null, new Buffer(output, 'base64').toString 'ascii'
