getType = (obj) -> Object.prototype.toString.call obj

compact = (arr) ->
  return (item for item in arr when not (getType(item) is '[object Undefined]'))

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
      unless getType(next) == '[object Function]'
        return curry naan, args..., next
      meat args..., next

    return naan

