$ROLLS = {} 
$LAST_ID = [0]

module Rollah
  class Roll
    attr_reader :id, :results, :total
    
    def initialize(dice = [])
      @dice = dice
      @id = Rollah.next_id
      $ROLLS[@id] = self
      roll!
    end
    
    def rolled_on
      @rolled_on.strftime("%B %d, %Y at %I:%M%p")
    end
    
    def roll!
      @rolled_on = Time.now
      @results = []
      @total = 0
      @dice.each do |die_type, times|
        times.times do
          value = Rollah.throw_die(die_type)
          @results << ["d#{die_type}", value]
          @total += value
        end
      end
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
      rolls_by_die_type = roll.downcase.split '+'
      all_rolls = rolls_by_die_type.map do |roll|
        roll = "1#{roll}" if roll.start_with? 'd'
        roll.split('d').map(&:to_i).reverse
      end
      Roll.new(all_rolls)
    end
  
    def throw_die(die)
      return die if @weighted
      rand(die) + 1
    end

    # "You know... for the tests"
    def weight_dice!
      @weighted = true
    end
  end
end
