require 'spec_helper'
require 'support/rom_user_context'

describe Axiom::Adapter::Redis do
  include_context "rom_user"

  it "can delete a user" do
    rom.session do |s|
      users = s[:users]
      jane = users.restrict(id: 2).one
      users.delete(jane)
      s.flush

      users.count.should == 1
    end

    rom.session do |s|
      s[:users].count.should == 1
    end
  end
end  
