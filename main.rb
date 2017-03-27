require_relative 'player.rb'
require_relative 'deck.rb'
require_relative 'interface.rb'
require_relative 'ai.rb'

class Main
  include Interface
  include AI

  def run
    system('clear')
    initialize_game
  end

  def exit
    puts 'До новых встреч!'
  end
end

app = Main.new
app.run
