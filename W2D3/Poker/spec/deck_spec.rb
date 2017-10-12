require 'deck'
require 'rspec'

describe Deck do
  subject(:deck) {Deck.new}
  describe "#initialize" do
    it "Inits 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "each card in deck is unique" do
      val_arr = deck.cards.map { |card| [card.value, card.suit] }
      expect(val_arr == val_arr.uniq).to be true
    end
  end

  describe "#draw_cards" do
    it "draws one card by default and takes it out of deck" do
      card_should = deck.cards.last
      card = deck.draw_cards
      expect(deck.cards.length).to eq(51)
      expect(card_should).to eq(card.first)
    end

    it "can draw up to three cards" do
      cards = deck.draw_cards(3)
      expect(deck.cards.length).to eq(49)
      expect(cards.length).to eq(3)
    end

    it "raises error if tries to draw more than 3" do
      expect { deck.draw_cards(4) }.to raise_error("Too many cards!")
    end
  end

  describe "#discard_cards" do
    let (:card) { double("card", val: 5, suit: :hearts)}
    it "discards two cards" do
      card_two = double("card_two", val: 10, suit: :hearts)
      cards = [card, card_two]
      deck.discard_cards(cards)
      expect(deck.cards[0..1]).to eq(cards)
    end

    it "raises error if tries to discard more than 3" do
      expect { deck.discard_cards([card,card,card,card]) }.to raise_error("Too many cards!")
    end
  end

  describe "#shuffle" do
    it "shuffles the deck" do
      start_cards = deck.cards.dup
      expect(deck.shuffle.cards).to_not eq(start_cards)
    end
  end
end
