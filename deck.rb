class Deck
  attr_reader :deck

  VALUE = %w(2 3 4 5 6 7 8 9 10 В Д К Т)
  CARD_SUIT = ["\u2660", "\u2666", "\u2665", "\u2663"]

  def initialize
  @deck = VALUE.product(CARD_SUIT)
  @deck.map! {|v, c_s| v + c_s}
  end

  def shuffle
    deck.shuffle!
  end

  def get_card
    deck.pop
  end

end