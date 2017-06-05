class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
    else
      return BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node == nil

    if value <= node.value
      node.left = BinarySearchTree.insert!(node.left, value)
    else
      node.right = BinarySearchTree.insert!(node.right, value)
    end
    node
  end

  def self.find!(node, value)
    return nil if node == nil
    return node if node.value == value

    if value < node.value
      return BinarySearchTree.find!(node.left, value)
    else
      return BinarySearchTree.find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] if node == nil
    new_array = []
    new_array << node.value
    new_array += BinarySearchTree.preorder!(node.left) if node.left
    new_array += BinarySearchTree.preorder!(node.right) if node.right
    new_array
  end

  def self.inorder!(node)
    return [] if node == nil

    new_array = []
    # return left half, node and right array

    new_array += BinarySearchTree.inorder!(node.left) if node.left
    new_array << node.value
    new_array += BinarySearchTree.inorder!(node.right) if node.right

    new_array
  end

  def self.postorder!(node)
    return [] if node == nil
    new_array = []
    new_array += BinarySearchTree.postorder!(node.left) if node.left
    new_array += BinarySearchTree.postorder!(node.right) if node.right
    new_array << node.value
    new_array
  end

  def self.height!(node)
    return -1 if node == nil

    left = BinarySearchTree.height!(node.left)
    right = BinarySearchTree.height!(node.right)
    return [left, right].max + 1
  end

  def self.max(node)
    return nil if node == nil
    return node if node.right == nil
    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil if node == nil
    return node if node.left == nil

    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil if node == nil
    return node.right if node.left == nil

    node.left = BinarySearchTree.delete_min!(node.left)
    node
  end

  def self.delete!(node, value)
    return nil if node == nil

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left if node.right == nil
      return node.right if node.left == nil
      temp = node
      node = temp.right.min
      node.right = BinarySearchTree.delete_min!(temp.right)
      node.left = temp.left
    end

    node
  end
end
