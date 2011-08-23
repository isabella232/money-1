class Numeric
  # Converts this numeric to a Money object in the default currency. It
  # multiplies the numeric value by 100 and treats that as cents.
  #
  #   100.to_money => #<Money @cents=10000>
  #   100.37.to_money => #<Money @cents=10037>
  def to_money
    Money.new(self)
  end
end

class String
  def to_money
    return Money.new(nil) if (self.nil?) || (self == "")
    if self.scan(/[a-zA-Z\!\"\§\$\%\&\/\(\)\=\?\*\’\ä\Ä\ö\Ö\ü\Ü\#\'\;\:\_\>\<\^\°\+]/).count == 0
      money = self.gsub(",",".")
      if money.scan(/[-]/).count < 2 
        return Money.new(nil) if (money.scan(/[-]/).count == 1) && (!money.starts_with? "-")
        return Money.new(money.to_f)
      end
    end
    Money.new(nil)
  end
end
