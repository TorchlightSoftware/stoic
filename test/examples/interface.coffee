i = 0
generateID = -> i = i+1

face = (decorators) ->
  {user: {name, email}} = decorators

  properties =
    create: (fields, next) ->
      id = generateID()

      user = @get id

      user.name.set fields.name, ->
        user.email.set fields.email, ->
          next null, user

    get: (id) ->
      user =
        id: id

      name user
      email user, ({after}) ->
        after ['get'], (context, email, next) ->
          next null, "<div>#{email}</div>"

      return user

  return properties

schema =
  'user:!{id}':
    name: 'String'
    email: 'String'

module.exports = ['User', face, schema]
