require "spec_helper"

describe Roll do
  before do
    Roll.weight_dice!
  end

  it "can be called" do
    roll = Roll.me_a("d4")
    roll.should_not be_rolled
  end

  it "can be rolled" do
    roll = Roll.me_a("d4")
    roll.roll!
    roll.should be_rolled
  end

  it "has a rolling date" do
    roll = Roll.me_a("d4")
    Timecop.freeze(Time.local(2013, 1, 27, 12, 05, 0)) do
      roll.roll!
    end
    roll.rolled_on.should eq("January 27, 2013 at 12:05PM")
  end
  
  it "rolls a single dice" do
    roll = Roll.me_a("d8")
    roll.roll!
    roll.total.should eq(8)
  end
  
  it "rolls a single dice" do
    roll = Roll.me_a("1d12")
    roll.roll!
    roll.total.should eq(12)
  end
  
  it "rolls multiple dice of the same type" do
    roll = Roll.me_a("3d6")
    roll.roll!
    roll.total.should eq(18)
  end
  
  it "rolls multiple dice of mixed types" do
    roll = Roll.me_a("1d20+3d6+1d4")
    roll.roll!
    roll.total.should eq(42)
  end
  
  it "understands negative rolls" do
    roll = Roll.me_a("-d4")
    roll.roll!
    roll.total.should eq(-4)
  end
  
  it "understands explicitly positive rolls" do
    roll = Roll.me_a("+2d4")
    roll.roll!
    roll.total.should eq(8)
  end
  
  it "subtracts or adds rolls" do
    roll = Roll.me_a("1d20-2d4+1d8")
    roll.roll!
    roll.total.should eq(20)
  end
  
  it "ignores spaces" do
    roll = Roll.me_a(" 1d20  + 2d4")
    roll.roll!
    roll.total.should eq(28)
  end
  
  it "ignores case" do
    roll = Roll.me_a("1D20+2d4")
    roll.roll!
    roll.total.should eq(28)
  end
  
  it "understands shorthand for a single dice" do
    roll = Roll.me_a("d20")
    roll.roll!
    roll.total.should eq(20)
  end
  
  it "understands sanity rolls" do
    roll = Roll.me_a("sanity")
    roll.roll!
    roll.total.should eq(100)
  end
  
  it "understands % rolls" do
    roll = Roll.me_a("%")
    roll.roll!
    roll.total.should eq(100)
  end
  
  it "understands percent rolls" do
    roll = Roll.me_a("percent")
    roll.roll!
    roll.total.should eq(100)
  end

  it "has detailed results" do
    roll = Roll.me_a("3d4+1d12")
    roll.roll!
    roll.results.should eq([["d4", 4], ["d4", 4], ["d4", 4], ["d12", 12]])
  end
  
  it "can be invalid" do
    Roll.me_a(" 2D4 + d12 - d4").should be_valid_roll

    Roll.me_a("2d").should_not be_valid_roll
    Roll.me_a("2z4").should_not be_valid_roll
  end
  
  it "can only be rolled if it's valid" do
    roll = Roll.me_a("2d")
    expect { roll.roll! }.to raise_error("Wrong roll syntax")
  end
end
