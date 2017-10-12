class Hand
  HANDS = {
    :high_card => 10,
    :pair => 9,
    :two_pair => 8,
    :three_kind => 7,
    :straight => 6,
    :flush => 5,
    :full_house => 4,
    :four_kind => 3,
    :straight_flush => 2,
    :royal_flush => 1
  }

  def initialize; end

  def self.best_hand(hand)
    in_hand = royal_flush(hand)
    return in_hand unless in_hand.empty?

    in_hand = straight_flush(hand)
    return in_hand unless in_hand.empty?

    in_hand = four_kind(hand)
    return in_hand unless in_hand.empty?

    in_hand = full_house(hand)
    return in_hand unless in_hand.empty?

    in_hand = flush(hand)
    return in_hand unless in_hand.empty?

    in_hand = straight(hand)
    return in_hand unless in_hand.empty?

    in_hand = three_kind(hand)
    return in_hand unless in_hand.empty?

    in_hand = two_pair(hand)
    return in_hand unless in_hand.empty?

    in_hand = pair(hand)
    return in_hand unless in_hand.empty?

    [:high_card, hand]
  end

  def self.compare_hands(hand1, hand2)
    best1 = best_hand(hand1)
    best2 = best_hand(hand2)
    if HANDS[best1[0]] < HANDS[best2[0]]
      return hand1
    elsif HANDS[best1[0]] > HANDS[best2[0]]
      return hand2
    else
      best1.each_index do |i|
        next if i == 0
        if best1[i] > best2[i]
          return hand1
        elsif best1[i] < best2[i]
          return hand2
        end
      end
      :tie
    end
  end

  private

  def self.royal_flush(hand)
    values = hand.map {|card| card.value}
    flush = flush(hand)
    return [] if flush.empty?

    (10..14).each do |num|
      return [] unless values.include?(num)
    end
    return [:royal_flush]
  end

  def self.straight_flush(hand)
    straight = straight(hand)
    return [] if straight.empty?

    flush = flush(hand)
    return [] if flush.empty?

    return [:straight_flush, straight[1]]
  end

  def self.flush(hand)
    suit = hand.first.suit
    hand.each do |card|
      return [] if card.suit != suit
    end
    [:flush]
  end

  def self.two_pair(hand)
    sorted = hand.sort_by {|card| card.value}
    values = sorted.map {|card| card.value}

    uniq = values.uniq
    pairs = []
    if uniq.length == 3
      if values.count(uniq[0]) == 2
        pairs << uniq[0]
      end
      if values.count(uniq[1]) == 2
        pairs << uniq[1]
      end
      if values.count(uniq[2]) == 2
        pairs << uniq[2]
      end
      high_card = values.select { |el| !pairs.include?(el)}
      return [:two_pair, pairs[1], pairs[0], high_card.first]
    end
    []
  end

  def self.straight(hand)
    sorted = hand.sort_by {|card| card.value}
    values = sorted.map {|card| card.value}

    return [:straight, sorted[-2].value] if values == [2,3,4,5,14]

    starting_value = sorted.first.value
    i = 0
    5.times do
      return [] unless sorted[i].value == starting_value
      i += 1
      starting_value+=1
    end
    [:straight, sorted[-1].value]
  end

  def self.four_kind(hand)
    values = hand.map {|card| card.value}
    values.each do |el|
      return [:four_kind, el] if values.count(el) == 4
    end
    []
  end

  def self.three_kind(hand)
    values = hand.map {|card| card.value}
    values.each do |el|
      return [:three_kind, el] if values.count(el) == 3
    end
    []
  end

  def self.full_house(hand)
    values = hand.map {|card| card.value}
    uniq = values.uniq
    if uniq.length == 2
      if values.count(uniq[0]) == 3
        return [:full_house, uniq[0]]
      else
        return [:full_house, uniq[1]]
      end
    end
    return []
  end

  def self.pair(hand)
    sorted = hand.sort_by {|card| card.value}
    values = sorted.map {|card| card.value}
    uniq = values.uniq
    pair = 0
    if uniq.length == 4
      uniq.each do |el|
        pair = el if values.count(el) == 2
      end
      high_card = values.select { |el| el != pair}
      return [:pair, pair, high_card.last]
    end
    []
  end
end
