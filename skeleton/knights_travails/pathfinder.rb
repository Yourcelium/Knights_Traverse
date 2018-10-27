require_relative "00_tree_node"

class KnightPathFinder
  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    build_move_tree
    @visited_positions = [@root_node]
  end

  def find_path(pos)
    
  end
  
  def build_move_tree
    
  end    
  
  def new_move_positions(pos)
    
    all_possible_moves = KnightPathFinder::valid_moves(pos) 

    
    all_possible_moves.reject { |move| @visited_positions.include?(move) }
  end
  
  def self.valid_moves(pos)
    all_possible_moves = []
  
    (1..2).each do |y|
      y_values = [y, -y]
      y_values.each do |y_value|
        # debugger
        x = 2 if y_value.abs == 1
        x = 1 if y_value.abs == 2
    
        all_possible_moves << [y_value, x]
        all_possible_moves << [y_value, -x]
      end
    end
    
    board_range = (0..7).to_a
    all_possible_moves.map { |move| [move.first + pos.first, move.last + pos.last]  }
    
    all_possible_moves.select { |move|  board_range.include?(move[0]) && board_range.include?(move[1]) }
    
    
  end
end