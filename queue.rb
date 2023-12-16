# The first node of the queue is called head and the last one tail.
# Queues grow to their tail and shrink from their head.

class Node
  attr_accessor :data, :next

  def initialize(data)
    self.data = data
    self.next = nil
  end
end

class Queue
  attr_accessor :head, :tail, :length

  def initialize
    self.head   = nil
    self.length = 0
  end

  def enqueue(data)
    node = Node.new data
    unless head
      self.head = node
    else
      self.tail.next = node
    end
    self.tail    = node
    self.length += 1
  end

  def dequeue
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
      dequeue
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
queue = Queue.new
queue.enqueue(n1)
queue.enqueue(n2)
queue.dequeue
queue.print

