require 'mongoid'

class Roll
  include Mongoid::Document
  
  field :roll_string
  field :results, type: Array
  field :rolled_time, type: DateTime
  
  def rolled_on
    return nil unless rolled_time
    rolled_time.strftime("%B %d, %Y at %I:%M%p")
  end

  def valid_roll?
    roll_string =~ /\A\s*\d*d\d\s*[\+\s\d*d\d]*\z/i
  end

  def total
    total = 0
    results.each do |result|
      total += result[1]
    end
    total
  end
  
  def roll!
    raise "Wrong roll syntax" unless valid_roll?
    self.rolled_time = Time.now

    rolls_by_die_type = roll_string.gsub(/\s+/, '').downcase.split '+'
    all_rolls = rolls_by_die_type.map do |roll|
      roll = "1#{roll}" if roll.start_with? 'd'
      roll.split('d').map(&:to_i).reverse
    end

    self.results = []
    all_rolls.each do |die_type, times|
      times.times { results << ["d#{die_type}", Roll.throw_die(die_type)] }
    end

    self
  end
  
  class << self
    def me_a(roll_string)
      Roll.new(roll_string: roll_string)
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
