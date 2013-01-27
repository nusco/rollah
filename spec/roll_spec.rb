$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "roll"

describe DiceRoller::Roll do
  before do
    DiceRoller.weight_dices!
  end

  it "throws a d4, d6, d8, d12 or d20" do
    DiceRoller::Roll.new({d4: 1}).result.should eq(4)
    DiceRoller::Roll.new({d6: 1}).result.should eq(6)
    DiceRoller::Roll.new({d8: 1}).result.should eq(8)
    DiceRoller::Roll.new({d12: 1}).result.should eq(12)
    DiceRoller::Roll.new({d20: 1}).result.should eq(20)
  end

  it "throws multiple dices of the same type" do
    DiceRoller::Roll.new({d4: 3}).result.should eq(12)
  end

  it "throws multiple dices of mixes types" do
    DiceRoller::Roll.new({d4: 3, d12: 1}).result.should eq(24)
  end
end
