{merge} = require './util'

Types =
  String:
  # alias       redis command
    append: ['append']
    bitcount: ['bitcount']
    bitop: ['bitop']
    decr: ['decr']
    decrby: ['decrby']
    get: ['get']
    getbit: ['getbit']
    getrange: ['getrange']
    getset: ['getset']
    incr: ['incr']
    incrby: ['incrby']
    incrbyfloat: ['incrbyfloat']
    psetnx: ['psetnx']
    set: ['set']
    setbit: ['setbit']
    setex: ['setex']
    setnx: ['setnx']
    setrange: ['setrange']
    strlen: ['strlen']

  Hash:
  # alias       redis command
    hdel: ['hdel']
    exists: ['hexists']
    get: ['hget']
    getall: ['hgetall']
    incrby: ['hincrby']
    incrbyfloat: ['hincrbyfloat']
    keys: ['hkeys']
    len: ['hlen']
    mget: ['hmget']
    mset: ['hmset']
    set: ['hset']
    setnx: ['hsetnx']
    vals: ['hvals']

  List:
  # alias       redis command
    all: ['lrange', 0, -1]
    blpop: ['blpop']
    brpop: ['brpop']
    brpoplpush: ['brpoplpush']
    index: ['lindex']
    insert: ['linsert']
    len: ['llen']
    lpop: ['lpop']
    lpush: ['lpush']
    lpushx: ['lpushx']
    range: ['lrange']
    lrem: ['lrem']
    set: ['lset']
    sort: ['sort']
    trim: ['ltrim']
    rpop: ['rpop']
    rpoplpush: ['rpoplpush']
    rpush: ['rpush']
    rpushx: ['rpushx']

  Set:
  # alias       redis command
    add: ['sadd']
    all: ['smembers']
    belongs: ['sismember']
    count: ['scard']
    card: ['scard']
    diff: ['sdiff']
    inter: ['sinter']
    ismember: ['sismember']
    members: ['smembers']
    pop: ['spop']
    randmember: ['srandmember']
    sort: ['sort']
    srem: ['srem']
    union: ['sunion']

  SortedSet:
  # alias       redis command
    sort: ['sort']
    add: ['zadd']
    card: ['zcard']
    count: ['zcount']
    incrby: ['zincrby']
    range: ['zrange']
    rangebyscore: ['zrangebyscore']
    rank: ['zrank']
    zrem: ['zrem']
    remrangebyrank: ['zremrangebyrank']
    remrangebyscore: ['zremrangebyscore']
    revrange: ['zrevrange']
    revrangebyscore: ['zrevrangebyscore']
    revrank: ['zrevrank']
    score: ['zscore']
    unionstore: ['zunionstore']

# these operations are available on all redis data types
Key =
# alias      redis command
  del: ['del']
  dump: ['dump']
  exists: ['exists']
  expire: ['expire']
  expireat: ['expireat']
  persist: ['persist']
  pexpire: ['pexpire']
  pexpireat: ['pexpireat']
  pttl: ['pttl']
  rename: ['rename']
  renamenx: ['renamenx']
  restore: ['restore']
  ttl: ['ttl']
  type: ['type']

for type, ops of Types
  merge Types, type, Key

module.exports = Types
