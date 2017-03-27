module Interface
  attr_reader :player, :dealer
  attr_accessor :deck, :flag

  OPTIONS =
    { 'Пропустить' => :skip_turn,
      'Взять карту' => :add_card,
      'Открыть карты' => :open_cards }.freeze

  def initialize_game
    puts 'Добро пожаловать в Black Jack v 1.0'
    puts 'Введите ваше имя, храбрый игрок:'
    name = gets.chomp
    self.player = Player.new(name)
    self.dealer = Player.new('Дилер')
    start_game
  end

  def start_game
    self.flag = 1
    raise 'У дилера больше нет денег!' if dealer.bank.zero?
    raise 'У вас больше нет денег!' if player.bank.zero?
    player.hand = []
    dealer.hand = []
    self.deck = Deck.new
    deck.shuffle
    player.bank -= 10
    dealer.bank -= 10
    player.add_from_deck(deck, 2)
    dealer.add_from_deck(deck, 2)
    loop do
      break if flag == 0
      menu
    end
  rescue StandardError => e
    puts e.message
    self.flag = 0 if dealer.bank.zero? || player.bank.zero?
  end

  def menu
    system('clear')
    puts "Здравствуйте, #{player.name}! У вас #{player.bank} долларов!"
    puts "У дилера #{dealer.bank} долларов!"
    puts "Ваши карты: #{player.hand}(#{player.points})    Карты дилера:#{close_hand}"
    puts "#{player.name} #{player.turn} Дилер #{dealer.turn}"
    puts 'Ваш ход:'
    user_answer = gets.chomp
    raise 'Такой команды нет!' unless OPTIONS.key?(user_answer)
    system('clear')
    send(OPTIONS[user_answer])
  end

  def continue
    puts 'Вы хотите продолжить (Д\Н)?'
    user_answer = gets.chomp
    if user_answer == 'д' || user_answer == 'Д'
      start_game
    elsif user_answer == 'н' || user_answer == 'Н'
      self.flag = 0
    else
      system('clear')
      continue
    end
  end

  private

  attr_writer :player, :dealer

  def tie
    puts 'Ничья!'
    player.bank += 10
    dealer.bank += 10
  end

  def skip_turn
    player.pass
    ai_turn
  end

  def add_card
    player.add_from_deck(deck, 1)
    ai_turn
    end_game if player.hand.size == 3 && dealer.hand.size == 3
  end

  def open_cards
    player.turn = 'открывает карты!'
    end_game
  end

  def close_hand
    answer = ''
    dealer.hand.size.times { answer += ' *' }
    answer
  end

  def end_game
    puts "Ваши карты: #{player.hand}(#{player.points})"
    puts "Карты дилера:#{dealer.hand}(#{dealer.points})"
    if (player.points > dealer.points || dealer.points > 21) && player.points < 22
      player.win
    elsif (dealer.points > player.points || player.points > 21) && dealer.points < 22
      dealer.win
    else
      tie
    end
    continue
  end
end
