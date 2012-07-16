## Information

<table>
<tr>
<td>Package</td><td>Redgoose</td>
</tr>
<tr>
<td>Description</td>
<td>Schemas for Redis</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.6</td>
</tr>
</table>

## Description

Duck Types?  No way!  Goose Types are for structured data.

Ideally we want to define a schema as follows, and have the models/data accessors generated for us:

### schema.coffee

```coffee-script
# NOTE: not supported yet, you must define an interface
module.exports =
  'user:!{id}':
    name: 'Cache'
    email: 'Cache'
```

This would allow you to write your domain logic like so:

### program.coffee

```coffee-script
should = require 'should'
redgoose = require 'redgoose'
schema = require './schema'
{User} = redgoose.models

u = User.get(1)

u.name.set 'Frank', (err, result) ->
  u.name.get (err, result) ->
    result.should.eql 'Frank'
```

We can support that syntax today, but you have to define an interface to go with your schema.  Here is a full document description with schema and interface that would allow the above program.coffee to run:

### schema.coffee

```coffee-script
face = (decorators) ->
  {user: {name, email}} = decorators

  get: (id) ->

    user =
      id: id

    name user
    email user

    return user

schema =
  'user:!{id}':
    name: 'Cache'
    email: 'Cache'

module.exports = ['User', face, schema]
```

## What the hell is going on here?

Well, looking at the schema above, there are a few things to notice.  The schema is a heiarchical namespace.  Each key extends the namespace within redis, and each value describes the type of data held there.  When Redgoose parses your schema, it will construct a set of decorators.  Decorators:

* Are specific to a data type
* Are used to attach Accessors to an object

The accessors they attach:

* Are aware of their key space
* Fill in tokens in the key with properties from the parent object

These decorators are the building blocks needed to assemble an interface.  Let's take a deeper look into that interface code.

```coffee-script
# we are passed the decorators generated from parsing the schema
face = (decorators) ->

  # let's pull them out of the object into local variables
  {user: {name, email}} = decorators

  # the get method will create an object that knows its id and can access user-stuff
  # note that it's not actually querying redis, that won't happen until an accessor is called
  get: (id) ->

    # the base object
    # the accessors will use this id to fill in !{id} in their key space whenever they are called
    user =
      id: id

    # decorate the user object with 'name' and 'email' accessors
    name user
    email user

    # return the completed object
    return user
```

This should make it very easy to construct the interface that you want to access your data.  Soon, we will support a sensible default interface, and then you can kiss your boilerplate goodbye, and say hello to sweet declarative goodness.

## Supported Decorator Types

### Redis

* Cache
* List
* Set

Other data types will be trivial to implement, it's just a few lines of boilerplate.  In the future this will be extensible as well, so you could add custom decorators for your application.

## Why didn't you use Redback for your data types?

Redback was not usable for this purpose due to the way they are handling namespace definitions and model creation.  The approach we are taking should lead to more power and flexibility in your data model.

## Questions? Comments?

Hit me up on twitter: @qbitmage

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
