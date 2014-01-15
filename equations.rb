require 'complex'

# ax + b = 0
class LinearEquation

  def initialize(a, b)
    @a, @b = a.to_f, b.to_f
  end

  def solve
    (-@b / @a)
  end
end

# ax^2 + bx + c = 0
class QuadraticEquation < LinearEquation

  def initialize(a, b, c)
    super(a, b)
    @c = c.to_f
  end

  # Math#sqrt will return a complex instance if necessary
  def solve
    # return "Imaginary Roots" if disc < 0 
    [(-@b - Math.sqrt(disc)) / (2 * @a), (-@b + Math.sqrt(disc)) / (2 * @a)].uniq
  end

  def disc
    disc = (@b * @b) - 4 * @a * @c #discriminant
  end

end