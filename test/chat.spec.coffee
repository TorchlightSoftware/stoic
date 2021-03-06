async = require 'async'
should = require 'should'
stoic = require '../lib/main'

describe 'chat schema', ->
  before ->
    stoic.init()

  beforeEach (done) ->
    @schema = require './examples/chat'
    stoic.load @schema
    done()

  it 'should let me access allChats', (done) ->
    {Chat} = stoic.models

    Chat.allChats.add 'bar', (err, res) ->
      Chat.allChats.belongs 'bar', (err, res) ->
        done()

  it 'should let me access chat fields', (done) ->
    {Chat} = stoic.models
    Chat.create (err, chat) ->

      chat.history.rpush 'foo', ->
        chat.history.rpush 'bar', ->
          chat.history.all (err, list) ->

            should.exist list
            list.should.include 'foo'
            list.should.include 'bar'
            done()

  it "should curry like nobody's business", (done) ->
    {Chat} = stoic.models
    Chat.create (err, chat) ->

      # perform some ops
      async.series [
        chat.history.rpush 'foo'
        chat.history.rpush 'bar'
        chat.history.all

      # get the result
      ], (err, data) ->
        [_..., list] = data

        # assert the data is good
        should.exist list
        list.should.include 'foo'
        list.should.include 'bar'
        done()
