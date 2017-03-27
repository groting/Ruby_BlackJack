class Player
  attr_accessor :name, :bank, :hand, :turn, :points

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
  end

  def add_from_deck(deck, value)
    raise 'Вы не можете взять карту!' if hand.size > 2
    value.times { hand << deck.get_card }
    get_points
    self.turn = 'берет карты!'
  end

  def win
    puts "#{name} выйграл!"
    self.bank += 20
  end

  def get_points
    self.points = 0
    hand.each do |card|
      value = card.chop
      value = if %w(В Д К).include?(value)
                10
              elsif value == 'Т'
                ace
              else
                value.to_i
              end
      self.points += value
    end
  end

  def pass
    self.turn = 'пропускает ход!'
  end

  private

  def ace
    value = (points + 11) < 22 ? 11 : 1
    value
  end
end
