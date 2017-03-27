module AI
  def ai_turn
    puts 'Ход дилера...'
    sleep(1)
    if player.points > dealer.points && player.points < 22
      ai_add_card
    else
      dealer.pass
    end
  end

  def ai_add_card
    dealer.hand.size < 3 ? dealer.add_from_deck(deck, 1) : dealer_pass
  end
end
