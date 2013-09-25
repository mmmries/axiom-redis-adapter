class Axiom::Adapter::Redis::Gateway < Axiom::Relation
  include Axiom::Relation::Proxy

  attr_reader :relation, :adapter

  def initialize(relation, adapter)
    @relation = relation
    @adapter  = adapter
  end

  def each(&block)
    tuples.each(&block)
  end

  def insert(tuples)
    adapter.insert(self, tuples)
    self
  end

  def delete(tuples)
    adapter.delete(self, tuples)
    self
  end

  private

  def tuples
    if relation.materialized?
      relation
    else
      Axiom::Relation.new(header, adapter.read(relation))
    end
  end
end
