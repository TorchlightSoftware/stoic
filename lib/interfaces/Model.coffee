i = 0
generateID = -> i = i+1

module.exports = (decorators) ->

  properties =
    create: (fields, next) ->
      id = generateID()

      instance = @get id

      for field, val of fields #TODO: use async
        user[field].set val

      next null, user

    get: (ids) ->
      base = ids

      for decorator in decorators
        decorator base

      return base

  return properties
