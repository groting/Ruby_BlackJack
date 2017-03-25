class Player
  attr_accessor :name, :bank, :hand, :turn, :points

  def initialize(name)
    @name =  name
    @bank = 100
    @hand = []
  end

  def add_from_deck(deck, value)
  value.times  { hand << deck.get_card}
  get_points
  end

  def win
    puts "#{name} выйграл!"
    self.bank += 20
  end

  def get_points
    self.points = 0
    hand.each do |card|
      value = card.chop
      if %w(В Д К).include?(value)
        value = 10
      elsif value == 'Т'
        value = ace
      else
        value = value.to_i
      end
      self.points += value
    end
  end

  private

  def ace
    (points + 11) < 22 ? value = 11 : value = 1
    value 
  end
end