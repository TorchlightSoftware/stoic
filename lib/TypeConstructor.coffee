# Type Constructor (type)
module.exports = (type) ->

  # Template (location)
  (accessor, localKey) ->

    # Decorator (model)
    (obj, lifecycle) ->
      lifecycle ?= ->

      # take the operator definitions from this type,
      # and wire them up to the target object
      obj[localKey] = {}
      for op, args of type
        obj[localKey][op] = accessor obj, lifecycle, op, args...

      return obj
