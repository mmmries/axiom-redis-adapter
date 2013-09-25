require 'bundler/setup'
require 'rspec'
require 'axiom-redis-adapter'
require 'rom'

RSpec.configure do |c|
  c.color = true
  c.order = :rand
end
