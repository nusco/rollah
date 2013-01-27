$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "roll"

describe DiceRoller::Roll do
  before do
    DiceRoller.weight_dices!
  end

  it "throws a single dice (d4, d6, d8, d12 or d20)" do
    DiceRoller::Roll.new({4 => 1}).total.should eq(4)
    DiceRoller::Roll.new({6 => 1}).total.should eq(6)
    DiceRoller::Roll.new({8 => 1}).total.should eq(8)
    DiceRoller::Roll.new({12 => 1}).total.should eq(12)
    DiceRoller::Roll.new({20 => 1}).total.should eq(20)
  end

  it "throws multiple dices of the same type" do
    DiceRoller::Roll.new({4 => 3}).total.should eq(12)
  end

  it "throws multiple dices of mixes types" do
    DiceRoller::Roll.new({4 => 3, 12 => 1}).total.should eq(24)
  end
end

describe DiceRoller do
  before do
    DiceRoller.weight_dices!
  end
  
  it "parses a single dice" do
    roll = DiceRoller.parse("1d12")
    roll.total.should eq(12)
  end
  
  it "parses multiple dice of the same type" do
    roll = DiceRoller.parse("3d6")
    roll.total.should eq(18)
  end
  
  it "parses multiple dice of mixed types" do
    roll = DiceRoller.parse("1d20+3d6+1d4")
    roll.total.should eq(42)
  end
  
  it "ignores spaces" do
    roll = DiceRoller.parse(" 1d20 + 2d4")
    roll.total.should eq(28)
  end
  
  it "ignores case" do
    roll = DiceRoller.parse("1D20+2d4")
    roll.total.should eq(28)
  end
end
