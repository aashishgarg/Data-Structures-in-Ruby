# Last in, first out order

class Node
  attr_accessor :data, :next

  def initialize(data)
    self.data = data
    self.next = nil
  end
end

class Stack
  attr_accessor :head, :tail, :length

  def initialize
    self.head   = nil
    self.length = 0
  end

  def push(data)
    node = Node.new data
    if length == 0
      self.tail = node
    end
    node.next = self.head
    self.head = node
    self.length += 1
  end

  def pop
    return nil unless self.length > 0

    self.head = self.head.next
    self.tail = nil if self.length == 1
    self.length -= 1
  end

  def peek
    self.head
  end

  def clear
    while self.peek
      pop
    end
  end

  def each
    return nil unless block_given?
    current = self.head
    while current
      yield current
      current = current.next
    end
  end

  def print
    if self.length == 0
      puts "empty"
    else
      self.each { |node| puts node.data }
    end
  end
end

n1 = Node.new(1)
n2 = Node.new(2)

stack = Stack.new
stack.push n1
stack.push n2

stack.pop

stack.print

stack.clear
