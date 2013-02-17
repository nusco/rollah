require 'mongoid'

class Roll
  include Mongoid::Document
  
  field :roll_string
  field :results, type: Array
  field :rolled_time, type: DateTime

  def rolled?
    rolled_time
  end
  
  def rolled_on
    rolled_time.strftime("%B %d, %Y at %I:%M%p")
  end

  def valid_roll?
    roll_string =~ /\A\s*\d*d\d\s*[\+\s\d*d\d]*\z/i
  end

  def total
    @total ||= results.map {|result| result[1] }.inject(&:+)
  end
  
  def roll!
    raise "Wrong roll syntax" unless valid_roll?
    self.rolled_time = Time.now
    self.results = parse_rolls.map {|dice| ["d#{dice}", Roll.roll(dice)] }
  end

  def parse_rolls
    rolls_by_dice = roll_string.gsub(/\s+/, '').downcase.split '+'
    multi_dice_rolls = rolls_by_dice.map do |roll|
      roll = "1#{roll}" if roll.start_with? 'd'
      roll.split('d').map(&:to_i).reverse
    end
    multi_dice_rolls.map {|dice, times| [dice] * times }.flatten
  end
  
  class << self
    def me_a(roll_string)
      Roll.new(roll_string: roll_string)
    end
    
    def roll(dice)
      return dice if @weighted
      rand(dice) + 1
    end

    # "You know... for the tests"
    def weight_dice!
      @weighted = true
    end
  end
end
