require "byebug"

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = [] 
  end

  def parent
    @parent
  end
  
  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    unless parent_node == nil
      parent_node.children << self if !parent_node.children.include?(self)
    end
  end
  
  def children
    @children
  end
  
  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise "I am an error! Fear me" unless children.include?(child_node)
    child_node.parent = nil
    @children.delete(child_node)
    
  end
  
  def value
    @value
  end
  
  def inspect
    @value
  end
  
  def dfs(target_value)
    return self if @value == target_value
    return nil if @children.empty?
    
    @children.each do |child_node|
      result = child_node.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end
  
  def bfs(target_value)
    queue = []
    queue << self

    until queue.empty?
      # debugger
      return queue.first if queue.first.value == target_value
      front = queue.shift
      front.children.each do |child_node|
        queue << child_node
      end
    end
    nil
  end
  
end

