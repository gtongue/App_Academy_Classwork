require "byebug"

class DynamicProgramming

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
    }
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1],[1,2],[2,1],[3]]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    @blair_cache[n] = blair_nums(n-1) + blair_nums(n-2) + (2*(n-1) - 1)
    @blair_cache[n]
  end

  def frog_hops_bottom_up(n)
    frog_cache = frog_cache_builder(n)
    frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1],[1,2],[2,1],[3]]
    }
    return frog_cache if n <= 3
    hops = []
    (4..n).to_a.each do |i|
      prev = [frog_cache[i - 1], frog_cache[i - 2], frog_cache[i - 3]]
      prev.each_with_index do |el, j|
        el.each do |hops1|
          frog_cache[j + 1].each do |hops2|
            hops.push(hops1+hops2)
          end
        end
      end
      frog_cache[i] = hops.uniq
    end
    frog_cache
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
