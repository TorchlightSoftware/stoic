# fake out ID generation
i = 0
rand = -> i += 1

# Interface for document
face = (decorators) ->

  # define decorators as local vars
  {chat: {
    visitor,
    visitorPresent,
    creationDate,
    allChats,
    history,
    operators
  }} = decorators

  facevalue =
    create: (cb) ->
      id = rand()
      chat = @get id
      chat.creationDate.set Date.now(), =>
        @allChats.add id, (err) ->
          cb err, chat

    get: (id) ->

      chat =
        id: id

      visitor chat
      visitorPresent chat
      creationDate chat
      history chat
      operators chat

      return chat

  allChats facevalue

  return facevalue

# Schema for document
schema =
  'chat:!{id}':
    history: 'List'
    visitor: 'String'
    visitorPresent: 'String'
    operators: 'Set'
    creationDate: 'String'
  chat:
    allChats: 'Set'

# Name, Interface, Schema
module.exports = ['Chat', face, schema]
