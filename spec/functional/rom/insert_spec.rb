require 'spec_helper'
require 'support/rom_user_context'

describe "Insert" do
  include_context "rom_user"

  it "can create a user" do
    rom.session do |s|
      new_user = s[:users].new(name: 'Benedict', id: 3)
      s[:users].save(new_user)
      s.flush
    end

    rom[:users].count.should == 3
    benedict = rom[:users].restrict(id: 3).one
    benedict.name.should == "Benedict"
  end
end
