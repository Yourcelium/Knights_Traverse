require_relative "00_tree_node"

class KnightPathFinder
  attr_reader :root_node
  
  def initialize(start_pos = [0,0])
    
    @root_node = PolyTreeNode.new(start_pos)
    @visited_positions = [@root_node]
    build_move_tree(@root_node)
  end

  def find_path(pos)
    
  end
  
  def build_move_tree(node)
    queue = []
    queue << @root_node
    
    until queue.empty?
      current = queue.shift
      all_possible_moves = new_move_positions(current.value)
      all_possible_moves.each do |possible_move|
        @visited_positions << possible_move
        child_node = PolyTreeNode.new(possible_move)
        current.add_child(child_node)
        queue << child_node
      end
    end
    @visited_positions = [@root_node]
  end
  
  def trace_path_back(node)
    return [node.value] if node.parent == nil 
    
    trace_path_back(node.parent) << node.value
  end
  
  def find_path(end_pos)
    queue = [@root_node]
    
    until queue.empty?
      return trace_path_back(queue.first) if queue.first.value == end_pos
      first = queue.shift
      first.children.each do |child_node|
        queue << child_node
      end
    end
    nil
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
        x = 2 if y_value.abs == 1
        x = 1 if y_value.abs == 2
    
        all_possible_moves << [y_value, x]
        all_possible_moves << [y_value, -x]
      end
    end
    
    board_range = (0..7).to_a
    all_possible_moves.map! { |move| [move.first + pos.first, move.last + pos.last]  }
    
    all_possible_moves.select { |move|  board_range.include?(move[0]) && board_range.include?(move[1]) }
  end
end

