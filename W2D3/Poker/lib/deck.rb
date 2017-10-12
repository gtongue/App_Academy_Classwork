require_relative 'card'

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    suits = [:diamonds, :clubs, :hearts, :spades]
    (1..13).each do |val|
      suits.each do |suit|
        @cards << Card.new(val, suit)
      end
    end
  end

  def draw_cards(num = 1)
    raise "Too many cards!" if num > 3
    drawn_cards = []
    num.times do
      drawn_cards << @cards.pop
    end
    drawn_cards
  end

  def discard_cards(cards)
    raise "Too many cards!" if cards.length > 3
    @cards = cards + @cards
  end

  def shuffle
    @cards.shuffle!
    self
  end
end
