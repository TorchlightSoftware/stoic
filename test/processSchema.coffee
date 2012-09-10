async = require 'async'
should = require 'should'
process = require '../lib/process'

describe 'processSchema.coffee:', ->

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
