require "./00_tree_node.rb"

class KnightPathFinder

  def initialize(arr)
    @position = arr
    @visited_positions = [arr]
    @move_tree = build_move_tree
  end

  def find_path(end_pos)
    correct_node = @move_tree.bfs(end_pos)
    trace(correct_node)
  end

  def trace(node)
    return [] if node.nil?
    trace(node.parent) + [node.value]
  end

  def build_move_tree
    root = PolyTreeNode.new(@position)
    current = root
    queue = [current]
    until queue.empty?
      new_positions = new_move_positions(current.value)

      new_children = new_positions.map{|loc| PolyTreeNode.new(loc)}
      new_children.each{|c| current.add_child(c)}
      queue.concat(new_children)

      current = queue.shift
    end
    root
  end



  def self.valid_moves(pos)
      changes = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]

      changes.map! do |change|
        x = change.first + pos.first
        y = change.last + pos.last
        if (x <= 7 && x >= 0 &&
            y <= 7 && y >= 0)
            [x,y]
        end
      end.compact
  end

  def new_move_positions(pos)
    puts @visited_positions
    new_positions = KnightPathFinder.valid_moves(pos) - @visited_positions
    @visited_positions.concat(new_positions)
    new_positions
  end







end
