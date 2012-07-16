async = require 'async'

# executes a query, including before and after callbacks
module.exports = (callbacks, origOp, op, key, args, ids, next) ->
  {client} = require './main'

  # each name is an event, and has a list of actions associated
  lifecycle =
    before: []
    command: [(args, next) ->
      #console.log 'key: ', key
      #console.log "op: [#{op}] args: #{args}"
      client[op] key, args..., next]
    after: []


  # grab context for events
  context =
    ids: ids
    op: origOp
    key: key

  # wrap a function for use with async
  wrap = (cb) ->
    (data, next) ->
      cb(context, data, next)

  # inject builders into the callback definitions
  # builders are functions that add to the lifecycle
  builders = {}
  builder = (event) ->
    builders[event] = (ops, cb) ->
      if origOp in ops
        lifecycle[event].push wrap cb

  builder event for event, actions of lifecycle when event isnt 'command'

  callbacks builders

  #console.log 'origOp: ', origOp if key.match /^sms/
  #console.log 'lifecycle: ', lifecycle if key.match /^sms/

  # queue up commands (use array to honor specific order)
  start = (next) -> next null, args
  commands = [start]
  events = ['before', 'command', 'after']
  for event in events
    commands.push cb for cb in lifecycle[event]

  # execute
  async.waterfall commands, (err, data) ->
    console.log "Redis Query Error:", err if err?
    next err, data
