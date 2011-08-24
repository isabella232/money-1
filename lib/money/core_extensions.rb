class Numeric
  # Converts this numeric to a Money object in the default currency. It
  # multiplies the numeric value by 100 and treats that as cents.
  #
  #   100.to_money => #<Money @cents=10000>
  #   100.37.to_money => #<Money @cents=10037>
  def to_money
    Money.new(self*100)
  end
end

class String
  def to_money
    return Money.new(nil) if (self.nil?) || (self == "")
    if !self.match(/(^[\-]?[1-9]\d{0,2}(\.\d{3})*?,\d{1,2}$)/).nil?
      return Money.new(self.gsub(".","").gsub(",",".").to_f * 100)
    end
    if !self.match(/(^[\-]?[1-9]\d{0,2}(,\d{3})*?\.\d{1,2}$)/).nil?
      return Money.new(self.gsub(",","").to_f * 100)
    end
    if !self.match(/^[\-]?(\d)*$/)
      return Money.new(self.to_f * 100)
    end
    Money.new(nil)
  end
end
