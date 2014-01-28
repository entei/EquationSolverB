require 'complex'

# ax + b = 0
class LinearEquation
  attr_accessor :a, :b

  def initialize(a, b)
    @a, @b = a, b
  end

  def solve
    [(-@b / @a)]
  rescue ZeroDivisionError => exception
    return exception
  end
end

# ax^2 + bx + c = 0
class QuadraticEquation < LinearEquation
  attr_accessor :a, :b, :c

  def initialize(a, b, c)
    super(a, b)
    @c = c
  end

  # Math#sqrt will return a complex instance if necessary
  def solve
    [(-@b - Math.sqrt(disc)) / (2 * @a), (-@b + Math.sqrt(disc)) / (2 * @a)].uniq
  rescue ZeroDivisionError => exception
    return exception
  end

  def disc
    (@b * @b) - 4 * @a * @c # discriminant
  end
end