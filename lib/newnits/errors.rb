module Newnits
  class IncompatibleUnitsError < StandardError
  end

  class UnknownUnitError < StandardError
  end

  class UnitsFileNotFoundError < StandardError
  end

  class IncompatibleExponentError < StandardError
  end
end
