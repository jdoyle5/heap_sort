class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []

  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  public
  def self.child_indices(len, parent_index)
    children = [2 * parent_index + 1, 2 * parent_index + 2]
    children.shift if children[0] >= len
    children.pop if children[1] >= len
    children
  end

  def self.parent_index(child_index)
    if child_index == 0
      raise ArgumentError.new("root has no parent")
    elsif child_index % 2 != 0
      return (child_index - 1) / 2
    elsif child_index % 2 == 0
      return (child_index - 2) / 2
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    children = self.child_indices(len, parent_idx)

    child_vals = []

    child_vals << array[children[0]] if children[0]
    child_vals << array[children[1]] if children[1]

    parent_val = array[parent_idx]

    until child_vals.empty? || (prc.call(parent_val, child_vals[0]) == -1 &&
      prc.call(array[parent_idx], array[children[1]]) == -1)

      if child_vals[0] < child_vals[1]
        array[child_vals[0]], array[parent_idx] = array[parent_idx], array[child_vals[0]]
      else
        array[child_vals[1]], array[parent_idx] = array[parent_idx], array[child_vals[1]]
      end



    end


  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return array if child_idx == 0

    parent_idx = self.parent_index(child_idx)

    if prc.call(array[child_idx], array[parent_idx]) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    end
  end
end

# p BinaryMinHeap.children_indices(5)
