require 'product'

class SpreadSheet < Product
  def revenue_recognitions(contract)
    [
      RevenueRecognition.new(contract.product,'SpreadSheet', contract.signed_on, contract.signed_on, (contract.revenue*2/3) + 1),
      RevenueRecognition.new(contract.product,'SpreadSheet', contract.signed_on, (Date.parse(contract.signed_on) + 30).to_s, (contract.revenue*1/3)),
    ]
  end
end
