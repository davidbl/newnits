module Newnits
  class Units
    require 'yaml'
    def self.set_up(file_path = nil)
      file_path ||= File.join(File.dirname(__FILE__),'units', 'units.yml') 
      @@units ||= []
      process_units_file file_path, @@units
    end

    def self.process_units_file(file_path, container = @@units)
      raise UnitsFileNotFoundError, "Units File Not Found: #{file_path}" unless File.exists?(file_path)
      unit_data = YAML::load_file(file_path)
      unit_data.each_pair  do |dimension, values|
        dim = dimension.to_sym
        values.each_pair do |name, value|
          container << Unit.new(name.to_sym, Rational(value.to_s), dim)
        end
      end
    end

    def self.units
      @@units
    end

    def self.add(*args)
      if args.size ==1 && args[0].is_a?(String)
        process_units_file(*args)
      else
        @@units <<  Unit.new(*args)
      end
    end

    def self.find(name)
      unit = @@units.select{ |e| name.to_s.match /^#{e.name}/}.first
      raise UnknownUnitError, "Unknown Unit '#{name.to_s}'" unless unit
      unit.dup
    end
  end #class Units
end
