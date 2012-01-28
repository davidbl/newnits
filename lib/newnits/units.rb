module Newnits
  class Units
    def self.set_up
      @@units =
       [
        [:meter, Rational(1), :length],
        [:millimeter, Rational('0.001'), :length],
        [:centimeter, Rational('0.01'), :length],
        [:decimeter, Rational('0.1'), :length],
        [:kilometer, Rational(1_000), :length],
        [:feet, Rational('0.3048'), :length],
        [:foot, Rational('0.3048'), :length],
        [:inch, Rational('0.0254'), :length],
        [:yard, Rational('0.9144'), :length],
        [:mile, Rational('1609.344'), :length],
        [:acre, Rational('4_046.856_422_4'), :area],
        [:hectare, Rational('10_000'), :area],
        [:second, Rational(1), :time],
        [:minute, Rational(60), :time],
        [:hour, Rational(3600), :time],
        [:day, Rational(86_400), :time],
        [:liter, Rational('0.001'), :volume],
        [:gallon, Rational('0.00454609'), :volume],
       ].map{ |e| Unit.new(*e)}
    end

    def self.units
      @@units
    end

    def self.add(args)
      @@units <<  Unit.new(*args)
    end

    def self.find(name)
      @@units.select{ |e| name.to_s.match /^#{e.name}/}.first
    end
  end #class Units
end
