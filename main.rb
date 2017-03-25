require_relative 'player.rb'
require_relative 'deck.rb'
require_relative 'interface.rb'

class Main
  include Interface

  def run
    system('clear')
    initialize_game
    loop do
      start_game
      menu
    end
  end
end

app = Main.new
app.run

           

