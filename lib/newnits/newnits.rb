module Newnits
  def find_unit(name)
    Units.find(name.to_sym)
  end
  module_function :find_unit

  def method_missing(sym, *args)
    if sym.to_s.match /(square|cubic)?_?([a-z]+)_?(squared|cubed)?/
      if $1
        unit = find_unit($2)
        unit.exponent = $1 == 'square' ? 2 : 3
      elsif $3
        unit = find_unit($2)
        unit.exponent = $3 == 'squared' ? 2 : 3
      else
        unit = find_unit($2)
      end
      Base.new(self, unit)
    else
      super
    end
  end


  class Base
    attr_accessor :value, :unit, :exponent
    def initialize(value, unit)
      @value = Rational(value, 1) rescue Rational(1,1)
      @unit = unit
      @exponent = nil
      @exponent =  Rational(1)*unit.exponent
      self
    end

    def in_base_unit
      (self.unit.value*self.value)
    end

    def to_the(power=1)
      @exponent = Rational(power)*@unit.exponent
      self
    end

    def squared
      to_the 2
    end

    def cubed
      to_the 3
    end

    def to_i
      @value.to_i
    end

    def to_f
      @value.to_f
    end

    def inspect
      "<#{self.class.name}##{self.object_id}, @value=#{@value}, @unit=#{@unit.name}, @to_f=#{@value.to_f}, @exponent=#{@exponent}>"
    end

    def to_s
      @value.to_s
    end

    def to(unit_name,exponent=1)
      target_unit = Newnits.find_unit(unit_name)
      target_unit.exponent = exponent
      raise IncompatibleUnitsError, "#{target_unit.dimension} is not compatible with #{self.unit.dimension}" unless target_unit.compatible_dimension?(self)
      raise IncompatibleExponentError, "Exponents are not compatible #{self.unit.exponent} : #{target_unit.exponent}" unless target_unit.compatible_exponent?(self)
      
      p target_unit
      new_exponent = self.exponent/target_unit.virtual_exponent(self)
      p new_exponent
      p target_unit.virtual_exponent(self)
      converted_value = (self.in_base_unit/(target_unit.value**target_unit.virtual_exponent(self)))**new_exponent
      Base.new(converted_value,target_unit)
    end
  end

end # module Newnits



