require 'elo'

class AICompetitor

  attr_accessor :ai, :elo_player, :wins, :loses

  def initialize(ai)
    @wins = 0
    @loses = 0
    @move_count = 0
    @hit_count = 0
    @ai = ai
    @elo_player = Elo::Player.new
  end

  def beats(comp)
    win
    comp.lose
    @elo_player.wins_from(comp.elo_player)
  end

  def name
    @ai.type
  end

  def placement_type
    @ai.placement_type
  end

  def rating
    @elo_player.rating
  end

  def win
    @wins += 1
  end

  def lose
    @loses += 1
  end

  def <=>(other)
    # A higher ranking is better
    -(rating <=> other.rating)
  end

end
