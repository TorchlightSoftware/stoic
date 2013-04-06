should = require 'should'

describe 'interpolate', ->
  it 'should put variables into a string', ->
    {interpolate} = require '../lib/util'

    scenarios = [
      # string, vars, expected
      ['session:!{id}', {id: 5}, [null, 'session:5']]
      ['session:!{id}', {id: 5, foo: 84}, [null, 'session:5']]
      ['account:!{accountId}:session:!{sessionId}', {accountId: 1, sessionId: 5}, [null, 'account:1:session:5']]
      ['session:!{id}', {}, [new Error 'Missing variable: id']]
      [null, {}, [new Error 'key must be a string']]
      ['', null, [null, '']]
    ]

    for scen in scenarios
      [string, vars, expected] = scen
      comment = "#{string} + #{vars} => #{expected}"

      result = interpolate(string, vars)
      result.should.eql expected, comment
