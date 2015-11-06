class PolyTreeNode

  attr_accessor :children, :parent
  attr_reader :value

  def initialize(value)
    @value = value
    @parent = nil #soon to be PolyTreeNode instance
    @children = [] #an array of PolyTreeNode instances
  end

  # a = PolyTreeNode.new("Harry")
  # b = PolyTreeNode.new("Mom")
  # a.parent=(b)


  def parent=(new_node)

    return if @parent == new_node

    old_parent = @parent
    @parent = new_node

    if @parent.nil?
      #emancipation. delete the child from the old parent's children.
      old_parent.children.delete(self)
      return
    end

    #adoption from no parents to new parents
    if old_parent.nil?
      @parent.children << self
      return
    end

    #adoption from old parents to new
    old_parent.children.delete(self)
    @parent.children << self

  end

  def add_child(child_node)
    return if child_node.nil?
    unless @children.include?(child_node)
      child_node.parent=(self)
    end
  end

  def print_tree
    @children.each{|child| child.print_tree}
    print self.value
  end

  def remove_child(child)
    raise "Not a child" unless @children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    #gonna use an array of tree nodes.
    #key methods are pop and push.
    return self if target_value == @value
    stack = [].concat(@children)
    until stack.empty?
      current_node = stack.shift
      possible_soln = current_node.dfs(target_value) #returns TreeNode or nil
      if !possible_soln.nil?
        return possible_soln
      end
    end
  end

  def bfs(target_value)
    queue = [] << self
    until queue.empty?
      current_node = queue.shift
      if current_node.value == target_value
        return current_node
      else
        queue.concat(current_node.children)
      end
    end
  end

end
