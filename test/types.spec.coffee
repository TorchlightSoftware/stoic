should = require 'should'
Types = require '../lib/types'

describe 'types', ->
  it 'should include general key operations', ->
    should.exist Types.Set.del, "Expected 'del' to exist on Set"
