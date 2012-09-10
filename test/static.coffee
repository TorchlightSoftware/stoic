async = require 'async'
should = require 'should'
stoic = require '..'

describe 'static.coffee:', ->
  before ->
    stoic.init()

  beforeEach (done) ->
    @schema = require './examples/AllSessions'
    stoic.load @schema
    done()

  it 'should load', (done) ->
    {AllSessions} = stoic.models

    AllSessions.count (err, count) ->
      should.not.exist err
      should.exist count
      count.should.eql 0
