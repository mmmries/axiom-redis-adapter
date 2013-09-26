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

    def insert(relation, tuples)
      tuples.each do |tuple|
        hash = attributes(relation.header, tuple)
        key = "#{relation.name}-#{hash[:id]}"
        redis.set key, Marshal.dump(hash)
      end
    end

    private
    attr_reader :schema, :redis

    def attributes(header, tuple)
      Hash[header.map(&:name).zip(tuple)]
    end
  end
end
