class FixedPlacement

  VALID_CELLS = (0...BattleshipGame::BOARD_SIZE).to_a.product((0...BattleshipGame::BOARD_SIZE).to_a)

   def ship_positions
    ships = []
    ships << Ship.new(:aircraft_carrier, 0, 0, :horizontal)
    ships << Ship.new(:battleship, 5, 0, :horizontal)
    ships << Ship.new(:destroyer, 0, 1, :horizontal)
    ships << Ship.new(:submarine, 3, 1, :horizontal)
    ships << Ship.new(:patrol_boat, 6, 1, :horizontal)

    # Make sure all ship placements are valid
    ship_cells = []
    ships.each do |ship|
      raise "#{ship.type} outside game board" unless (ship.cells - VALID_CELLS).empty?
      raise "#{ship.type} overlaps another ship" unless (ship.cells - ship_cells).length == ship.cells.length
      ship_cells += ship.cells
    end

    return ships
  end 

  def type
    "Fixed"
  end

end
