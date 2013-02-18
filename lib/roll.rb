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
    clean_roll_string =~ /^([\+\-]\d*d\d+)+$/
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
    rolls_by_dice = clean_roll_string.gsub('+', ' +').gsub('-', ' -').split ' '
    multi_dice_rolls = rolls_by_dice.map do |roll|
      rolls, dice = roll[1..-1].split('d').map(&:to_i)
      dice = -dice if roll[0] == '-'
      [dice, rolls]
    end
    multi_dice_rolls.map {|dice, times| [dice] * times }.flatten
  end
  
  def clean_roll_string
    result = roll_string.gsub(/\s+/, '').downcase
    return "+1d100" if ['sanity', '%', 'percent'].include? result
    result = "+#{result}" unless result.start_with? '+' or result.start_with? '-'
    result.gsub! /\+d/, '+1d'
    result.gsub! /\-d/, '-1d'
    result
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
