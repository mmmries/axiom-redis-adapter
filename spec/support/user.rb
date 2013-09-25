require 'virtus'
class User
  include Virtus

  attribute :name, String
  attribute :id, Integer
end
