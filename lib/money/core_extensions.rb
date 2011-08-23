class Numeric
  # Converts this numeric to a Money object in the default currency. It
  # multiplies the numeric value by 100 and treats that as cents.
  #
  #   100.to_money => #<Money @cents=10000>
  #   100.37.to_money => #<Money @cents=10037>
  def to_money
    Money.new(self * 100)
  end
end

class String
  # Parses the current string and converts it to a Money object.
  # Excess characters will be discarded.
  #
  #   '100'.to_money       # => #<Money @cents=10000>
  #   '100.37'.to_money    # => #<Money @cents=10037>
  #   '100 USD'.to_money   # => #<Money @cents=10000, @currency="USD">
  #   'USD 100'.to_money   # => #<Money @cents=10000, @currency="USD">
  #   '$100 USD'.to_money   # => #<Money @cents=10000, @currency="USD">
  def to_money
    return Money.new(nil) if self.nil?
    if self.scan(/[a-zA-Z\!\"\§\$\%\&\/\(\)\=\?\*\’\ä\Ä\ö\Ö\ü\Ü\#\'\;\:\_\>\<\^\°\+]/).count == 0
      money = self.gsub(",",".")
      if money.scan(".").count == 0
        Money.new(money * 100)
      end
      if money.split(".").count == 2 && self.scan(/[-]/).count <= 1
        Money.new((money.to_f * 100).to_i)
      end
    end
    Money.new(nil)
  end
end
