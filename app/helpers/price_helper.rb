module PriceHelper
  def price(val, decimal)
    "RM" + number_with_precision(val, :precision => decimal)
  end

  def decimal(val)
    number_with_precision(val, :precision => 2)
  end
end
