require File.dirname(__FILE__) + '/gameplay/ship'
require File.dirname(__FILE__) + '/util/battleship_board'
require File.dirname(__FILE__) + '/gameplay/battleship_game'
require File.dirname(__FILE__) + '/gameplay/ai_competitor'
require File.dirname(__FILE__) + '/gameplay/ai_comparator'
require File.dirname(__FILE__) + '/ai/placement/random_ship_placement'
require File.dirname(__FILE__) + '/ai/placement/random_horizontal_placement'
require File.dirname(__FILE__) + '/ai/placement/random_vertical_placement'
require File.dirname(__FILE__) + '/ai/placement/fixed_placement'
require File.dirname(__FILE__) + '/ai/helpers/ai_helper'
require File.dirname(__FILE__) + '/ai/helpers/attack_helper'
require File.dirname(__FILE__) + '/ai/strategy/basic_battleship_ai'
require File.dirname(__FILE__) + '/ai/strategy/hunter_ai'
require File.dirname(__FILE__) + '/ai/strategy/random_ai'

placements = []
placements << RandomShipPlacement.new
# placements << RandomHorizontalPlacement.new
# placements << RandomVerticalPlacement.new
placements << FixedPlacement.new

ais = []
placements.each do |placement|
   ais << HunterAI.new(placement)
   ais << RandomAI.new(placement)
  ais << BasicAI.new(placement)
end

comparator = AIComparator.new(ais, 10)
comparator.compare_ais
