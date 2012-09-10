module.exports =
  model: 'Instance'
  name: 'UserPhoto'
  ids:
    userId: 'Number'
    photoId: 'Id'

  source: 'Object' #implied

  schema:
    filename: 'String:filename:required'
    shortname: 'String'
    description: 'String'
    meta:
      type: 'Hash'
      schema:
        timestamp: 'String'
        location: 'String'
