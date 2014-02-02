require 'complex'

# ax + b = 0
class LinearEquation
  attr_accessor :a, :b

  def initialize(a, b)
    @a, @b = a.to_f, b.to_f
  end

  def solve
    if @a.zero?
      'Divide by zero!'
    else
      [(-@b / @a).round(2)]
    end
  end
end

# ax^2 + bx + c = 0
class QuadraticEquation < LinearEquation
  attr_accessor :a, :b, :c

  def initialize(a, b, c)
    super(a.to_f, b.to_f)
    @c = c.to_f
  end

  # Math#sqrt will return a complex instance if necessary
  def solve
    if @a.zero? # solve linear equation
      @a = @b
      @b = @c
      super
    else
      [(-@b - Math.sqrt(disc)) / (2 * @a).round(2), (-@b + Math.sqrt(disc)) / (2 * @a)].uniq
    end
  end

  def disc
    (@b * @b) - 4 * @a * @c # discriminant
  end
end