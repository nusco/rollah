module DiceRoller
  class Roll
    def initialize(dices)
      @dices = dices.to_a
    end
    
    def total
      @total ||= total!
    end
    
    def total!
      result = 0
      @dices.each do |dice_type, times|
        times.times { result += DiceRoller.throw_dice(dice_type) }
      end
      result
    end
  end
  
  def self.parse(roll)
    rolls_by_dice_type = roll.downcase.split '+'
    all_rolls = rolls_by_dice_type.map do |roll|
      roll = "1#{roll}" if roll.start_with? 'd'
      times, dice = roll.split('d').map(&:to_i)
    end
    Roll.new(all_rolls)
  end

  def self.parse_dice_type(throw)
    Roll.new({"d#{dice}" => times})
  end
  
  def self.throw_dice(dice)
    return dice if @weighted
    rand(dice) + 1
  end

  # "You know... for the tests"
  def self.weight_dices!
    @weighted = true
  end
end
