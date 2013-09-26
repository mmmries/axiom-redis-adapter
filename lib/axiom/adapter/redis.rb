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
        redis.set key(relation, tuple), Marshal.dump(hash)
      end
    end

    def delete(relation, tuples)
      tuples.each do |tuple|
        redis.del key(relation, tuple)
      end
    end

    private
    attr_reader :schema, :redis

    def attributes(header, tuple)
      Hash[header.map(&:name).zip(tuple)]
    end

    def key(relation, tuple)
      hash = attributes(relation.header, tuple)
      "#{relation.name}-#{hash[:id]}"
    end
  end
end
