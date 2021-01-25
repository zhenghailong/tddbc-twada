require 'date'

class Contract
  attr_accessor :product, :signed_on

  def sign(product, signed_on)
    @product = product
    @signed_on = signed_on
  end

  def revenue
    @product.price
  end

  def revenue_recognition(recognition_date = signed_on)
    revenue_recognitions = product.revenue_recognitions(self)
    revenue_recognitions.find { |recognition| recognition.date == recognition_date }
  end

  def all_revenue_recognitions
    product.revenue_recognitions(self)
  end
end
