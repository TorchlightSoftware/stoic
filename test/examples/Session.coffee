# hash backed model
module.exports =
  name: 'Session'
  interface: 'Model' # Model, Static
  #ids:
    #id: 'Id' # Id/Uid (auto-increment), String

  source:
    type: 'Hash'
    #filters: ['base64']

  schema:
    #timestamp: 'String:date'
    username: 'String'
    pictureCount: 'Number'

#Session.get(3).getall (sessionData) -> sessionData
