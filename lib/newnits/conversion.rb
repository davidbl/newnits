module Newnits
  class Conversion
    attr_accessor :base

    def initialize(base, target_unit, target_exponent)
      @base = arg

    end

    private

    def convert_to(target_unit)
      raise IncompatibleUnitsError, "#{target_unit.dimension} is not compatible with #{@base.unit.dimension}" unless target_unit.compatible_dimension?(@base)
      raise IncompatibleExponentError, "Exponents are not compatible #{@base.unit.exponent} : #{target_unit.exponent}" unless target_unit.compatible_exponent?(@base)
      # Base.new(@base.in_base_unit/target_unit.conversion_value(@base),target_unit)
      Base.new((@base.in_base_unit/target_unit.value)**@base.exponent,target_unit)
    end

    def method_missing(sym, *args)
      if sym.to_s.match /(square|cubic)?_?([a-z]+)_?(squared|cubed)?/
        if $1
          unit = Newnits.find_unit($2)
          unit.exponent = $1 == 'square' ? 2 : 3
        elsif $3
          unit = Newnits.find_unit($2)
          unit.exponent = $3 == 'squared' ? 2 : 3
        else
          unit = Newnits.find_unit($2)
        end
        convert_to(unit)
      else
        super
      end
    end
  end #class Conversion
end
