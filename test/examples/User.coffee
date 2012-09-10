# simple object model
module.exports =
  model: 'Instance'
  name: 'User'

  #source: 'Object'

  schema:
    name: 'String:required'
    email:
      type: 'String'
      filters: ['required', 'email']
    password: 'String:password'
