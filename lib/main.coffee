redis = require 'redis'
process = require './process'
{merge} = require './util'

module.exports =

  # use an existing redis client or create one
  init: (options) ->
    @client ?= options?.client or redis.createClient()
    @types ?= require './types'

  # load a model from a schema def
  load: (schema) ->
    throw new Error "No redis client is loaded." unless @client?
    throw new Error "Please provide a schema" unless schema?
    model = process schema
    @models[model.name] = model
    return model

  # load custom types in
  loadTypes: (types) ->
    merge @, 'types', types

  # get a list of models (constructed from schemas)
  models: {}
