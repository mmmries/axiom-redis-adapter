require 'spec_helper'
require 'support/rom_user_context'

describe Axiom::Adapter::Redis do
  include_context "rom_user"

  it "can find create a user" do
    rom.session do |s|
      new_user = s[:users].new(name: 'Benedict', id: 3)
      s[:user].save(new_user)

      s[:user].count.should == 3
      benedict = s[:user].restrict(id: 3).one
      benedict.should == user
    end
  end
end
