require 'support/user'
shared_context "rom_user" do
  let(:rom){ ROM::Environment.setup(redis: 'redis://localhost:6379/0') }
  let(:redis){ ::Redis.new(host: 'localhost', port: '6379') }

  before :each do
    rom.schema do
      base_relation :users do
        repository :redis

        attribute :id,   Integer
        attribute :name, String

        key :id
      end
    end

    rom.mapping do
      users do
        map :id, :name
        model User
      end
    end

    redis.flushdb

    redis.set "users-1", Marshal.dump({id: 1, name: 'John'})
    redis.set "users-2", Marshal.dump({id: 2, name: 'Jane'})
  end
end
