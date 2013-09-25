require 'rom/support/axiom/adapter'
require 'redis'
require 'axiom/adapter/redis/gateway'

module Axiom::Adapter
  class Redis
    extend Axiom::Adapter

    uri_scheme :redis

    def initialize(uri)
      @redis = ::Redis.new(host: uri.host, port: uri.port)
      @schema = {}
    end

    def [](name)
      schema[name]
    end

    def []=(name, relation)
      schema[name] = Gateway.new(relation, self)
    end

    def read(relation)
      attributes = relation.header.map(&:name)
      keys = redis.keys "#{relation.name}-*"
      hashes = keys.map do |key|
        hash = Marshal.load(redis.get(key))
        hash.values_at(*attributes)
      end
    end

    private
    attr_reader :schema, :redis
  end
end
