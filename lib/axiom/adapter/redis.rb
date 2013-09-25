require 'redis'
module Axiom::Adapter
  class Redis
    extend Adapter

    uri_scheme :redis

    def initialize(uri)
      @redis = Redis.new(host: uri.host, port: uri.port)
      @schema = {}
    end

    
  end
end
