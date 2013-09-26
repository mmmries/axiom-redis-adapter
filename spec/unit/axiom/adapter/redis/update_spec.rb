require 'spec_helper'
require 'support/rom_user_context'

describe Axiom::Adapter::Redis do
  include_context "rom_user"

  it "can update a user" do
    rom.session do |s|
      users = s[:users]
      john = users.restrict(id: 1).one
      john.name = "Jonathan"
      users.save(john)
      s.flush
    end

    rom.session do |s|
      users = s[:users]
      john = users.restrict(id: 1).one
      john.name.should == "Jonathan"
      users.count.should == 2
    end
  end
end
