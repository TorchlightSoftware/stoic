getType = (obj) -> Object.prototype.toString.call(obj).slice 8, -1

compact = (arr) ->
  return (item for item in arr when not (getType(item) is 'Undefined'))

curry = (fn, args...) ->
  args = compact args
  fn.bind fn.prototype, args...

module.exports =

  getType: getType
  compact: compact
  curry: curry

  base: (key) ->
    key.replace /:?!{\w+}/g, ''

  merge: (obj, key, value) ->
    return obj[key] = value unless obj[key]?
    obj[key][k] = v for k, v of value


  # given a function, wrap it in naan and curry, then cook it
  # In English: Enables autocurrying, so if you haven't provided the callback
  # yet you'll get a curried function instead of premature execution.
  tandoor: (meat) ->
    naan = (args..., next) ->
      unless getType(next) == 'Function'
        return curry naan, args..., next
      meat args..., next

    return naan

  interpolate: (template, vars) ->
    while token = /!{\w+}/g.exec template
      [token] = token
      varName = token.slice 2, -1
      return ["Missing variable: #{varName}"] unless vars[varName]?
      template = template.replace token, vars[varName]

    [null, template]
