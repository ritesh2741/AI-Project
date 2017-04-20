require 'pry'
require 'terminal-table'
require 'term/ansicolor'

class String
  include Term::ANSIColor
end

class BattleshipBoard

  def print(ai_1, ai_1_ships, ai_1_moves, ai_2, ai_2_ships, ai_2_moves)
    table = Terminal::Table.new do |t| 
      t.style = {:width => 100}
      t << ["AI 1 (#{ai_1.type}, #{ai_1.placement_type})", "AI 2 (#{ai_2.type}, #{ai_2.placement_type})"]
      t << :separator
      t << [ships_table(ai_1_ships, ai_2_moves), ships_table(ai_2_ships, ai_1_moves)]
    end
    puts table
  end

private

  def ships_table(ships, moves)
    ship_cells = {}
    ships.each do |ship|
      ship.cells.each do |cell|
        if moves.include?(cell)
          ship_cells[cell] = ship.type.to_s[0].upcase.red
        else
          ship_cells[cell] = ship.type.to_s[0].upcase.green
        end
      end
    end

    moves.each do |cell|
      ship_cells[cell] = '*' unless ship_cells[cell]
    end

    table = Terminal::Table.new do |t| 
      t << ['-'.blue, *(0...BattleshipGame::BOARD_SIZE).collect { |x| x.to_s.blue }]
      (0...BattleshipGame::BOARD_SIZE).each do |y|
        t << :separator
        t << [y.to_s.blue, *(0...BattleshipGame::BOARD_SIZE).collect { |x| ship_cells[[x, y]] || '' }]
      end
    end
    return table
  end

end
