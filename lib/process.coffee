Model = require './Model'
Decorator = require './Decorator'
{getType, base, merge} = require './util'

# helper functions

# walk schema nodes, creating keypath and looking for values
# accepts: json schema
# returns: an array of key/value pairs

walk = (keypath, node) ->
  nodeType = getType node
  switch nodeType

    # Define or reference a type
    when 'Array'
      [name, face, schema] = node
      return Model name, face, walk(null, schema)

    # Append to key namespace
    when 'Object'
      obj = {}
      for k, v of node
        newpath = if keypath? then "#{keypath}:#{k}" else k
        merge obj, [base k], walk(newpath, v)

      return obj

    # Reference a type with no options
    when 'String'
      return Decorator keypath, node

    else throw new Error "Unexpected node type #{nodeType} while parsing schema.\nKey: #{k}\nVal: #{v}"

module.exports = (schema) ->
  return walk null, schema
