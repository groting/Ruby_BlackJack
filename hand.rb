class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_from_deck(deck, value)
  value.times  { cards << deck.get_card}
  end
end