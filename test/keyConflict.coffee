async = require 'async'
should = require 'should'
redgoose = require '../lib/main'

describe 'multiple items', ->
  before ->
    redgoose.init()

  beforeEach (done) ->
    @schema = require './examples/chat'
    redgoose.load @schema
    done()

  it 'should not interfere with each other', (done) ->

    # make some chats
    {Chat} = redgoose.models
    Chat.create (err, chat1) ->
      Chat.create (err, chat2) ->

        # add some visitors
        async.series [
          chat1.visitor.set 'bob'
          chat2.visitor.set 'frank'
          chat1.visitor.get
          chat2.visitor.get
        ], (err, [_, __, vis1, vis2]) ->

          # visitor names should be retained
          vis1.should.eql 'bob'
          vis2.should.eql 'frank'
          done()

