{getType, tandoor} = require './util'
execute = require './execute'

# construct a data accessor for a given key and type
module.exports = (basekey, typeName) ->
  {types} = require './main'
  TypeConstructor = require './TypeConstructor'

  template = TypeConstructor types[typeName]

  throw new Error "Data type [#{typeName}] not loaded, did you mean to define it?" unless template

  # data accessor
  # accepts:
  #   vars: interpolate into key
  #   lifecycle: callbacks to run at various stages
  #   op: operation to run on redis
  #   args: additional args
  #   next: callback
  accessor = tandoor (vars, lifecycle, origOp, op, args..., next) ->

    #console.log "vars: #{vars}, op: #{op}, args: #{args}, next: #{typeof next}"

    # interpolate vars into key
    key = basekey
    while match = /!{\w+}/g.exec key
      [match] = match
      id = match.slice 2, -1
      return next "Missing ID: #{id}" unless vars[id]?
      key = basekey.replace match, vars[id]

    #console.log 'key: ', key
    #console.log "op: [#{op}] args: #{args}"

    # perform data operation
    execute lifecycle, origOp, op, key, args, vars, next

  [_..., localKey] = basekey.split ':'
  template accessor, localKey
