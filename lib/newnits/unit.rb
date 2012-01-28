module Newnits
  class Unit
    @@exponents = {length: Rational(1), area: Rational(2), volume: Rational(3), time: Rational(1)}
    attr_reader :name, :value, :dimension
    attr_accessor  :exponent
    def initialize(name, value, dimension)
      @name = name
      @value = value
      @dimension = dimension
      @exponent = 1 # @@exponents[dimension]
      self
    end

    def compatible_with?(other)
      compatible_dimension(other) && compatible_exponent?(other)
    end

    def compatible_dimension?(other)
      p self
      p other
      case self.dimension
      when :length
        (other.unit.dimension == :length && self.exponent == other.exponent) || (other.unit.dimension == :area && self.exponent == 2) || (other.unit.dimension == :volume && self.exponent == 3)
      when :area
        other.unit.dimension == :area || (other.unit.dimension == :length && other.exponent == 2)
      when :volume
        other.unit.dimension == :volume || (other.unit.dimension == :length && other.exponent == 3)
      when :time
        other.unit.dimension == :time
      end
      # self.dimension == other.unit.dimension
    end

    def compatible_exponent?(other)
      self.exponent == other.exponent
      true
    end

    def conversion_value(base)
      self.value#**(self.exponent)
    end

    def virtual_exponent(other)
      other.unit.dimension == self.dimension ? 1 : @@exponents[dimension]
    end
  end
end
