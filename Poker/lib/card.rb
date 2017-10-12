class Card
  attr_reader :value, :suit

  def initialize(val, suit)
    @value = val
    @suit = suit
  end

  def ==(card)
    @value == card.value && @suit == card.suit
  end
  
end
