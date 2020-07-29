class Order
  attr_accessor :id, :delivered, :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id]
    @delivered = attributes[:delivered] || false
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
  end

  def delivered?
    @delivered
  end

  def undelivered?
    !delivered?
  end
end
