require 'array'
require 'rspec'

describe Array do
  describe "#my_uniq" do
    it  "returns uniq elements in array" do
      expect([1,2,1,3,3].my_uniq).to eq([1,2,3])
    end

    it "does not modify sender" do
      a = [1,2,1,3,3]
      a.my_uniq
      expect(a).to eq([1,2,1,3,3])
    end
  end

  describe "#two_sum" do
    it "returns matching pairs" do
      expect([-1, 0, 2, -2, 1].two_sum).to include([0, 4])
      expect([-1, 0, 2, -2, 1].two_sum).to include([2, 3])
    end

    it "returns pairs in order" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0,4],[2, 3]])
    end
  end

  describe "#my_transpose" do
    it "returns transposed array" do
      array = [[0,1,2],[3,4,5],[6,7,8]]
      result = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
       expect(my_transpose(array)).to eq(result)
    end
  end

  describe "#stock_picker" do
    prices = [100, 95, 40, 200, 1000, 50]

    it "returns most profitable pair" do
      expect(stock_picker(prices)).to eq([2,4])
    end
  end
end
