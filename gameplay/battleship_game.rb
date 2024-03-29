class BattleshipGame

  BOARD_SIZE = 10

  attr_reader :winner

  def initialize(ai_1, ai_2, game_number)
    @ai_1 = ai_1
    @ai_2 = ai_2
    @moves = { ai_1 => [], ai_2 => [] } 
    @ships = {}
    @winner = nil
    @game_number = game_number
    @printer = BattleshipBoard.new
  end

  def run_game
    init_game(@game_number)

    until game_over?
      @current_player = not_current_ai
      #p "AI #{@current_player == @ai_1 ? 1 : 2} move"
      make_move(@current_player)
    end
    accuracy = ((17.0/@moves[@current_player].count)*100).round(2)
    puts "Game #{@game_number + 1} over AI type #{@current_player.type} wins with accuracy of #{accuracy} % (hit:moves ratio)"
    @winner = @current_player
    @printer.print(@ai_1, @ships[@ai_1], @moves[@ai_1],
                   @ai_2, @ships[@ai_2], @moves[@ai_2])
  end

  def init_game(game_number)
    puts "Starting game #{game_number}"
    @ai_1.new_game
    @ai_2.new_game

    @ships[@ai_1] = ship_positions(@ai_1)
    @ships[@ai_2] = ship_positions(@ai_2)

    @moves = { @ai_1 => [], @ai_2 => [] } 

    # Alternate who starts first
    @current_player = @game_number % 2 == 0 ? @ai_1 : @ai_2
  end

  def ship_positions(ai)
    ships = ai.ship_positions
    ships.each do |ship|
      raise "Invalid position #{ship} from ai #{ai.type}" unless ship.valid_placement?
    end
    
    ship_cells = ships.collect { |exist_ship| exist_ship.cells }.flatten(1)
    raise "Ships overlap for ai #{ai.type}" unless ship_cells == ship_cells.uniq

    return ships
  end

  def game_over?
    @ships[@ai_1].detect{ |ship| ship.alive? }.nil? || @ships[@ai_2].detect{ |ship| ship.alive? }.nil? 
  end

  def make_move(ai)
    move_x, move_y = ai.move

    if @moves[ai].include?([move_x, move_y])
      raise "Move (#{move_x}, #{move_y}) repeated by #{ai.type}" 
    else
      @moves[ai] << [move_x, move_y]
    end

    hit_ship = @ships[not_current_ai].detect do |ship|
      ship.hit?(move_x, move_y)
    end

    #p "x: #{move_x} y: #{move_y} hit: #{hit_ship.to_s}"

    move_outcome = {
      :x => move_x, 
      :y => move_y, 
      :hit => hit_ship != nil,
      :sunk => hit_ship && hit_ship.sunk?,
      :ship_type => (hit_ship.type rescue nil)
    }

    @ai_1.move_outcome(move_outcome.merge(:opponents_move => @current_player == @ai_2))
    @ai_2.move_outcome(move_outcome.merge(:opponents_move => @current_player == @ai_1))
  end

  def not_current_ai
    @current_player == @ai_1 ? @ai_2 : @ai_1
  end

end
