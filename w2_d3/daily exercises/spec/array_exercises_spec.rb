require "rspec"
require "array_exercises"

describe Array do
  let(:arr) {[1,1,3,4,5,5]}

  context "#my_uniq" do
    it "takes out duplicates" do
      expect(arr.my_uniq).to eq(arr.uniq)
    end
  end

  context "#two_sum" do
    it "find indexes that sum to 0" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
  end
end

describe "#my_transpose" do
  it "transposes rows and columns" do
    expect(my_transpose([[0, 1, 2], [3, 4, 5], [6, 7, 8]])).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end
end

describe "#stock_picker" do
  it "picks most profitable pair of days" do
    expect(stock_picker([5,1,3,8,2])).to eq([1,3])
  end
end

describe TowersOfHanoi do
  let(:game) {TowersOfHanoi.new}
  context "#initialize" do
    it "defaults to 3 arrays within an array" do
      expect(game.stacks.length).to eq(3)
    end

    it "first array within the array has [3,2,1]" do
      expect(game.stacks[0]).to eq([3,2,1])
    end
  end

  context "#move" do
    it "moves a disc onto another stack" do
      game.move([0,1])

      expect(game.stacks).to eq([[3,2],[1],[]])
    end

  end

  context "#over?" do
    let(:finished_game) {TowersOfHanoi.new([[],[3,2,1],[]])}
    it "checks if game is over" do
      expect(finished_game).to be_over
    end

    it "returns false if game is not over" do
      expect(game).to_not be_over
    end
  end

end
