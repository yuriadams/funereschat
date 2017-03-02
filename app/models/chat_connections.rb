class ChatConnections
  REDIS_KEY = 'connected_nodes'
  REDIS_URL = 'redis://localhost:6379/1'

  def self.redis
    @redis ||= Redis.new(url: REDIS_URL)
  end

  def self.all
    redis.smembers(REDIS_KEY)
  end

  def self.add(uid)
    redis.sadd(REDIS_KEY, uid)
  end

  def self.remove(uid)
    redis.srem(REDIS_KEY, uid)
  end
end
