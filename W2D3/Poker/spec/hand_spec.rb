require 'hand'
require 'rspec'

describe Hand do
  describe "#best_hand" do
    it "gets royal flush" do
      card1 = double("card1", value: 10, suit: :diamonds)
      card2 = double("card2", value: 11, suit: :diamonds)
      card3 = double("card3", value: 12, suit: :diamonds)
      card4 = double("card4", value: 13, suit: :diamonds)
      card5 = double("card5", value: 14, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:royal_flush])
    end
    context "straight_flush" do
      it "gets straight_flush with ace" do
        card1 = double("card1", value: 14, suit: :diamonds)
        card2 = double("card2", value: 2, suit: :diamonds)
        card3 = double("card3", value: 3, suit: :diamonds)
        card4 = double("card4", value: 4, suit: :diamonds)
        card5 = double("card5", value: 5, suit: :diamonds)
        hand = [card1, card2, card3, card4, card5]
        expect(Hand.best_hand(hand)).to eq([:straight_flush, card5.value])
      end

      it "gets straight_flush without ace" do
        card1 = double("card1", value: 5, suit: :diamonds)
        card2 = double("card2", value: 6, suit: :diamonds)
        card3 = double("card3", value: 7, suit: :diamonds)
        card4 = double("card4", value: 8, suit: :diamonds)
        card5 = double("card5", value: 9, suit: :diamonds)
        hand = [card1, card2, card3, card4, card5]
        expect(Hand.best_hand(hand)).to eq([:straight_flush, card5.value])
      end
    end

    it "gets four_kind" do
      card1 = double("card1", value: 5, suit: :diamonds)
      card2 = double("card2", value: 5, suit: :hearts)
      card3 = double("card3", value: 5, suit: :clubs)
      card4 = double("card4", value: 5, suit: :spades)
      card5 = double("card5", value: 9, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:four_kind, card1.value])
    end

    it "gets full_house" do
      card1 = double("card1", value: 2, suit: :diamonds)
      card2 = double("card2", value: 2, suit: :hearts)
      card3 = double("card3", value: 6, suit: :clubs)
      card4 = double("card4", value: 6, suit: :spades)
      card5 = double("card5", value: 6, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:full_house, card3.value])
    end

    it "gets flush" do
      card1 = double("card1", value: 2, suit: :diamonds)
      card2 = double("card2", value: 3, suit: :diamonds)
      card3 = double("card3", value: 6, suit: :diamonds)
      card4 = double("card4", value: 9, suit: :diamonds)
      card5 = double("card5", value: 11, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:flush])
    end

    context "straight" do
      it "gets straight without ace" do
        card1 = double("card1", value: 2, suit: :diamonds)
        card2 = double("card2", value: 3, suit: :hearts)
        card3 = double("card3", value: 4, suit: :clubs)
        card4 = double("card4", value: 5, suit: :spades)
        card5 = double("card5", value: 6, suit: :diamonds)
        hand = [card1, card2, card3, card4, card5]
        expect(Hand.best_hand(hand)).to eq([:straight, card5.value])
      end

      it "gets straight with ace" do
        card1 = double("card1", value: 2, suit: :diamonds)
        card2 = double("card2", value: 3, suit: :hearts)
        card3 = double("card3", value: 4, suit: :clubs)
        card4 = double("card4", value: 5, suit: :spades)
        card5 = double("card5", value: 14, suit: :diamonds)
        hand = [card1, card2, card3, card4, card5]
        expect(Hand.best_hand(hand)).to eq([:straight, card4.value])
      end
    end
    it "gets three_kind" do
      card1 = double("card1", value: 2, suit: :diamonds)
      card2 = double("card2", value: 2, suit: :hearts)
      card3 = double("card3", value: 2, suit: :clubs)
      card4 = double("card4", value: 5, suit: :spades)
      card5 = double("card5", value: 14, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:three_kind, card1.value])
    end

    it "gets two_pair" do
      card1 = double("card1", value: 2, suit: :diamonds)
      card2 = double("card2", value: 2, suit: :hearts)
      card3 = double("card3", value: 4, suit: :clubs)
      card4 = double("card4", value: 4, suit: :spades)
      card5 = double("card5", value: 14, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:two_pair, card3.value, card1.value, card5.value])
    end

    it "gets pair" do
      card1 = double("card1", value: 2, suit: :diamonds)
      card2 = double("card2", value: 2, suit: :hearts)
      card3 = double("card3", value: 5, suit: :clubs)
      card4 = double("card4", value: 4, suit: :spades)
      card5 = double("card5", value: 14, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:pair, card1.value,card5.value])
    end

    it "gets high card" do
      card1 = double("card1", value: 2, suit: :diamonds)
      card2 = double("card2", value: 3, suit: :hearts)
      card3 = double("card3", value: 8, suit: :clubs)
      card4 = double("card4", value: 4, suit: :spades)
      card5 = double("card5", value: 14, suit: :diamonds)
      hand = [card1, card2, card3, card4, card5]
      expect(Hand.best_hand(hand)).to eq([:high_card,hand])
    end
  end

  describe "#compare_hands" do
    describe "Different ranks" do
      it "hand 1 wins" do
        card1 = double("card1", value: 2, suit: :diamonds)
        card2 = double("card2", value: 3, suit: :hearts)
        card3 = double("card3", value: 4, suit: :clubs)
        card4 = double("card4", value: 5, suit: :spades)
        card5 = double("card5", value: 14, suit: :diamonds)
        hand1 = [card1, card2, card3, card4, card5]

        card6 = double("card1", value: 2, suit: :diamonds)
        card7 = double("card2", value: 2, suit: :hearts)
        card8 = double("card3", value: 5, suit: :clubs)
        card9 = double("card4", value: 4, suit: :spades)
        card10 = double("card5", value: 14, suit: :diamonds)
        hand2 = [card6, card7, card8, card9, card10]

        expect(Hand.compare_hands(hand1, hand2)).to eq(hand1)
      end

      it "hand 2 wins" do
        card1 = double("card1", value: 2, suit: :diamonds)
        card2 = double("card2", value: 3, suit: :hearts)
        card3 = double("card3", value: 4, suit: :clubs)
        card4 = double("card4", value: 5, suit: :spades)
        card5 = double("card5", value: 14, suit: :diamonds)
        hand2 = [card1, card2, card3, card4, card5]

        card6 = double("card1", value: 2, suit: :diamonds)
        card7 = double("card2", value: 2, suit: :hearts)
        card8 = double("card3", value: 5, suit: :clubs)
        card9 = double("card4", value: 4, suit: :spades)
        card10 = double("card5", value: 14, suit: :diamonds)
        hand1 = [card6, card7, card8, card9, card10]

        expect(Hand.compare_hands(hand1, hand2)).to eq(hand2)
      end
    end
    describe "Same ranks" do
      it "handles equal ranks not tie" do
        card1 = double("card1", value: 2, suit: :diamonds)
        card2 = double("card2", value: 2, suit: :hearts)
        card3 = double("card3", value: 4, suit: :clubs)
        card4 = double("card4", value: 4, suit: :spades)
        card5 = double("card5", value: 14, suit: :diamonds)
        hand1 = [card1, card2, card3, card4, card5]

        card6 = double("card1", value: 2, suit: :diamonds)
        card7 = double("card2", value: 2, suit: :hearts)
        card8 = double("card3", value: 4, suit: :clubs)
        card9 = double("card4", value: 4, suit: :spades)
        card10 = double("card5", value: 5, suit: :diamonds)
        hand2 = [card6, card7, card8, card9, card10]

        expect(Hand.compare_hands(hand1, hand2)).to eq(hand1)
      end
      it "handles tie" do
        card1 = double("card1", value: 2, suit: :diamonds)
        card2 = double("card2", value: 2, suit: :hearts)
        card3 = double("card3", value: 4, suit: :clubs)
        card4 = double("card4", value: 4, suit: :spades)
        card5 = double("card5", value: 14, suit: :diamonds)
        hand1 = [card1, card2, card3, card4, card5]

        card6 = double("card1", value: 2, suit: :diamonds)
        card7 = double("card2", value: 2, suit: :hearts)
        card8 = double("card3", value: 4, suit: :clubs)
        card9 = double("card4", value: 4, suit: :spades)
        card10 = double("card5", value: 14, suit: :diamonds)
        hand2 = [card6, card7, card8, card9, card10]

        expect(Hand.compare_hands(hand1, hand2)).to eq(:tie)
      end
    end
  end
end
