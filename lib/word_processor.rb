require 'product'
require 'date'

class WordProcessor < Product
  def revenue_recognitions(contract)
    [
      RevenueRecognition.new(contract.product,'WordProcessor', contract.signed_on, contract.signed_on, contract.revenue)
    ]
  end
end
