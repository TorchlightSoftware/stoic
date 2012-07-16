async = require 'async'
should = require 'should'
redgoose = require '../lib/main'

describe 'simple schema', ->
  before ->
    redgoose.init()
  beforeEach (done) ->
    @schema =
      'user:!{id}':
        name: 'String'
        email: 'String'

    redgoose.load @schema
    done()

  it 'should load', (done) ->
    should.exist redgoose.models.user
    should.exist redgoose.models.user.name

    name = redgoose.models.user.name

    user = {id: 1}
    name user

    user.name.set 'Frank', ->
      user.name.get (err, result) ->
        result.should.eql 'Frank'
        done()
