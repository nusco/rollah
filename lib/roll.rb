$ROLLS = {} 
$LAST_ID = [0]

module Rollah
  class Roll
    attr_reader :id
    
    def initialize(dices = {})
      @dices = dices.to_a
      @id = Rollah.next_id
      $ROLLS[@id] = self
    end
    
    def total
      @total ||= total!
    end
    
    def total!
      result = 0
      @dices.each do |dice_type, times|
        times.times { result += Rollah.throw_dice(dice_type) }
      end
      result
    end
  end

  class << self
    def next_id
      $LAST_ID[0] = $LAST_ID[0] + 1
    end
  
    def find(roll_id)
      $ROLLS[roll_id]
    end
  
    def parse(roll)
      rolls_by_dice_type = roll.downcase.split '+'
      all_rolls = rolls_by_dice_type.map do |roll|
        roll = "1#{roll}" if roll.start_with? 'd'
        roll.split('d').map(&:to_i)
      end
      Roll.new(all_rolls)
    end

    def parse_dice_type(throw)
      Roll.new({"d#{dice}" => times})
    end
  
    def throw_dice(dice)
      return dice if @weighted
      rand(dice) + 1
    end

    # "You know... for the tests"
    def weight_dices!
      @weighted = true
    end
  end
end
