module DiceRoller
  class Roll
    def initialize(dices)
      @dices = dices
    end
    
    def result
      @result ||= result!
    end
    
    def result!
      result = 0
      @dices.each do |dice, times|
        dicemax = dice.to_s.gsub(/^d/, '').to_i
        times.times { result += DiceRoller.throw_dice(dicemax) }
      end
      result
    end
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
