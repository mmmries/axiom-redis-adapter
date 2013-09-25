require 'spec_helper'

describe Axiom::Adapter::Redis do
  let(:rom){ ROM::Environment.setup(redis: 'redis://localhost:6379/11') }
  
  before :each do
    rom.schema do
      base_relation :users do
        repository :memory

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
  end

  it "can find users" do
    rom.session do |s|
      s[:users].count.should == 2
      john = s[:users].restrict(id: 1).one
      john.name.should == 'John'
      john.id.should == 1
    end
  end
end
