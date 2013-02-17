$: << File.expand_path("../../lib", File.dirname(__FILE__))

require "roll"
require "timecop"

describe Roll do
  before do
    Roll.weight_dice!
  end

  it "has a rolling date" do
    Timecop.freeze(Time.local(2013, 1, 27, 12, 05, 0)) do
      roll = Roll.me_a("d4")
      roll.rolled_on.should be_nil
      
      roll.roll!
      roll.rolled_on.should eq("January 27, 2013 at 12:05PM")
    end
  end
  
  it "throws a single dice (d4, d6, d8, d12 or d20)" do
    Roll.me_a("d4").roll!.total.should eq(4)
    Roll.me_a("d6").roll!.total.should eq(6)
    Roll.me_a("d8").roll!.total.should eq(8)
    Roll.me_a("d12").roll!.total.should eq(12)
    Roll.me_a("d20").roll!.total.should eq(20)
  end
  
  it "rolls a single dice" do
    roll = Roll.me_a("1d12").roll!
    roll.total.should eq(12)
  end
  
  it "rolls multiple dice of the same type" do
    roll = Roll.me_a("3d6").roll!
    roll.total.should eq(18)
  end
  
  it "rolls multiple dice of mixed types" do
    roll = Roll.me_a("1d20+3d6+1d4").roll!
    roll.results.should eq([["d20", 20], ["d6", 6], ["d6", 6], ["d6", 6], ["d4", 4]])
    roll.total.should eq(42)
  end
  
  it "ignores spaces" do
    roll = Roll.me_a(" 1d20  + 2d4").roll!
    roll.total.should eq(28)
  end
  
  it "ignores case" do
    roll = Roll.me_a("1D20+2d4").roll!
    roll.total.should eq(28)
  end
  
  it "accepts shorthand for a single dice" do
    roll = Roll.me_a("d20").roll!
    roll.total.should eq(20)
  end

  it "has detailed results" do
    roll = Roll.me_a("3d4+1d12").roll!
    roll.results.should eq([["d4", 4], ["d4", 4], ["d4", 4], ["d12", 12]])
  end
  
  it "can be invalid" do
    Roll.me_a(" 2D4 + d12 ").should be_valid_roll
    Roll.me_a("2d").should_not be_valid_roll
    Roll.me_a("2z4").should_not be_valid_roll
    Roll.me_a("2d4 - 3d10").should_not be_valid_roll
  end
  
  it "can only be rolled if it's valid" do
    expect { Roll.me_a("2d").roll! }.to raise_error("Wrong roll syntax")
  end
end
