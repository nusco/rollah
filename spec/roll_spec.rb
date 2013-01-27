$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "roll"

describe Rollah::Roll do
  before do
    Rollah.weight_dices!
  end

  it "has a unique id" do
    roll1 = Rollah::Roll.new
    roll2 = Rollah::Roll.new
    roll1.id.should_not eq(roll2.id)
  end
  
  it "throws a single dice (d4, d6, d8, d12 or d20)" do
    Rollah::Roll.new({4 => 1}).total.should eq(4)
    Rollah::Roll.new({6 => 1}).total.should eq(6)
    Rollah::Roll.new({8 => 1}).total.should eq(8)
    Rollah::Roll.new({12 => 1}).total.should eq(12)
    Rollah::Roll.new({20 => 1}).total.should eq(20)
  end

  it "throws multiple dices of the same type" do
    Rollah::Roll.new({4 => 3}).total.should eq(12)
  end

  it "throws multiple dices of mixes types" do
    Rollah::Roll.new({4 => 3, 12 => 1}).total.should eq(24)
  end
end

describe Rollah do
  before do
    Rollah.weight_dices!
  end
  
  it "finds rolls by id" do
    3.times { Rollah::Roll.new }
    roll = Rollah::Roll.new
    Rollah.find(roll.id).should equal(roll)
  end
  
  it "parses a single dice" do
    roll = Rollah.parse("1d12")
    roll.total.should eq(12)
  end
  
  it "parses multiple dice of the same type" do
    roll = Rollah.parse("3d6")
    roll.total.should eq(18)
  end
  
  it "parses multiple dice of mixed types" do
    roll = Rollah.parse("1d20+3d6+1d4")
    roll.total.should eq(42)
  end
  
  it "ignores spaces" do
    roll = Rollah.parse(" 1d20 + 2d4")
    roll.total.should eq(28)
  end
  
  it "ignores case" do
    roll = Rollah.parse("1D20+2d4")
    roll.total.should eq(28)
  end
end
