require 'spec_helper'
require 'support/rom_user_context'

describe Axiom::Adapter::Redis do
  include_context "rom_user"

  it "can find users" do
    rom.session do |s|
      s[:users].count.should == 2
      john = s[:users].restrict(id: 1).one
      john.name.should == 'John'
      john.id.should == 1
    end
  end
end
