class Toh
  attr_reader :towers
  def start
    [[3,2,1],[],[]]
  end

  def initialize(board = self.start)
    @towers = board
  end

  def move(from, to)
    from_el = @towers[from].last
    to_el = @towers[to].last
    if  to_el.nil? || from_el < to_el
      @towers[to] << @towers[from].pop
    else
      raise "NO"
    end
  end

  def win?
    (1...@towers.length).each do |i|
      return true if @towers[i].length == 3
    end
    return false
  end

  def render
    @towers.each do |tower|
      puts tower.to_s
    end
  end

  def play
    puts "Let's play!"

    until win?
      render
      puts "Enter a move"
      from, to  = gets.chomp.split(",").map(&:to_i)
      begin
        move(from, to)
      rescue
        puts "Can't move bigger ring ontop of smaller"
        retry
      end
    end
    "You win!"
  end

end

if __FILE__ == $PROGRAM_NAME
  toh = Toh.new
  toh.play
end
