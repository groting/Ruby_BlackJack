module Interface
  attr_reader :player, :diler
  attr_accessor :deck

  OPTIONS = 
  {'Пропустить' => :skip_turn, 
   'Взять карту' => :add_card,
   'Открыть карты' => :open_cards}

  def initialize_game
    puts 'Добро пожаловать в Black Jack v 1.0'
    puts 'Введите ваше имя, храбрый игрок:'
    name = gets.chomp
    self.player = Player.new(name)
    self.diler = Player.new('Дилер')
  end

  def start_game
    player.hand = []
    diler.hand = []
    self.deck = Deck.new
    deck.shuffle
    player.bank -= 10
    diler.bank -= 10
    player.add_from_deck(deck, 2)
    diler.add_from_deck(deck, 2)
  end

  def menu
    system('clear')
    puts "Здравствуйте, #{player.name}! У вас #{player.bank} долларов!"
    puts "У дилера #{diler.bank} долларов!"
    puts "Ваши карты: #{player.hand}(#{player.points})    Карты дилера:#{close_hand}"
    puts "Диллер #{diler.turn}!" unless diler.turn.nil?
    puts "Ваш ход:"
    user_answer = gets.chomp
    raise 'Такой команды нет!' unless OPTIONS.key?(user_answer) 
    system('clear')
    send(OPTIONS[user_answer])
    ai_turn
  end

  def continue?
    puts 'Вы хотите продолжить (Д\Н)?'
    user_answer = gets.chomp
    if user_answer == 'д' || user_answer == 'Д'
      true
    elsif user_answer == 'н' || user_answer == 'Н'
      return
    else
      system('clear')
      continue?
    end
  end

  private

  attr_writer :player, :diler

  def tie
    puts 'Ничья!'
    player.bank += 10
    diler.bank += 10
  end

  def skip_turn
    player.turn = 'Пропуск'
    menu
  end

  def add_card
    player.turn = 'Взял карту'
    puts deck
    player.add_from_deck(deck, 1)
    end_game if player.hand.size == 3 && diler.hand.size == 3
    menu
  end

  def open_cards
    player.turn = 'Открывает карты'
    end_game
  end

  def close_hand
    answer = ''
    diler.hand.size.times {answer += ' *'}
    answer
  end

  def end_game
    puts "Ваши карты: #{player.hand}(#{player.points})"
    puts "Карты дилера:#{diler.hand}(#{diler.points})"
    if (player.points > diler.points || diler.points > 21) && player.points < 22
      player.win
    elsif (diler.points > player.points || player.points >21) && diler.points < 22
      diler.win
    else
      tie
    end
    continue?
  end

  def ai_turn
    puts 'Я походил!'
  end
end
