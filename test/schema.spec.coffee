async = require 'async'
should = require 'should'
stoic = require '../lib/main'

describe 'simple schema', ->
  before ->
    stoic.init()
  beforeEach (done) ->
    @schema =
      'user:!{id}':
        name: 'String'
        email: 'String'

    stoic.load @schema
    done()

  it 'should load', (done) ->
    should.exist stoic.models.user
    should.exist stoic.models.user.name

    name = stoic.models.user.name

    user = {id: 1}
    name user

    user.name.set 'Frank', ->
      user.name.get (err, result) ->
        result.should.eql 'Frank'
        done()
