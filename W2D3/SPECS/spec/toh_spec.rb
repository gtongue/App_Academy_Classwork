require 'toh'
require 'rspec'

describe Toh do
  subject(:toh) {Toh.new}

  describe "#initialize" do
    it "Inits in first slot" do
      expect(toh.towers[0]).to eq([3,2,1])
    end
  end

  describe "#move" do
    it "Tests if move moves ring" do
      toh.move(0,1)
      expect(toh.towers[1]).to eq([1])
      toh.move(0,2)
      expect(toh.towers[2]).to eq([2])
    end
    it "Tests can't move bigger ring to smaller ring" do
      toh.move(0,1)
      expect {toh.move(0,1)}.to raise_error("NO")
    end
  end
#
  describe "#won" do
    it "Doesn't win right away" do
      expect(toh.win?).to be false
    end

    it "Wins when all rings are on the right side" do
      toh_win = Toh.new([[],[],[3,2,1]])
      expect(toh_win.win?).to be_truthy
    end

    it "Wins when all rings are in the middle" do
      toh_win = Toh.new([[],[3,2,1],[]])
      expect(toh_win.win?).to be_truthy
    end

    it "Doesn't win on first tower ever" do
      toh.move(0,1)
      toh.move(1,0)
      expect(toh.win?).to be false
    end

  end
end
