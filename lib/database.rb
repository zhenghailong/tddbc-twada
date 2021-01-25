require 'product'

class Database < Product
  def revenue_recognitions(contract)
    [
      RevenueRecognition.new(contract.product,'Database', contract.signed_on, contract.signed_on, (contract.revenue/3) + 1),
      RevenueRecognition.new(contract.product,'Database', contract.signed_on, (Date.parse(contract.signed_on) + 60).to_s, (contract.revenue/3)),
      RevenueRecognition.new(contract.product,'Database', contract.signed_on, (Date.parse(contract.signed_on) + 120).to_s, (contract.revenue/3)),
    ]
  end
end
