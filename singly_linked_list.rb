# Head -> Node -> Tail
# Operations -> Insert/Remove/Traverse

class Node
  attr_accessor :value, :next

  def initialize(value)
    self.value = value
    self.next = nil
  end
end

class SinglyLinkedList
  attr_accessor :head, :tail, :length

  def initialize
    self.head = nil
    self.tail = nil
    self.length = 0
  end

  def insert(item)
    node = Node.new(item)
    head.nil? ? self.head = node : self.tail.next = node
    self.tail = node
    self.length += 1
  end

  # The complexity of this method is O(n).
  def remove(node)
    return nil if node.nil?

    if node == head
      if self.head.next.nil?
        self.head = self.tail = nil
      else
        self.head = self.head.next
      end
    else
      tmp = self.head
      while tmp && tmp.next != node
        tmp = tmp.next
      end
      tmp.next = node.next if tmp
    end
    self.length -= 1
  end

  # The complexity of this method is O(1).
  def cat(list)
    return nil if list.nil?

    self.tail.next = list.head
    self.length += list.length
  end

  # This method removes all elements from the list. Since we have to walk the whole list, the complexity is O(n).
  def clear
    while self.length > 0
      remove self.head
    end
  end

  def find_first(&predicate)
    return nil unless block_given?

    current = self.head
    while current
      return current if predicate.call(current)
      current = current.next
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
      self.each { |item| puts item.value }
    end
  end
end

list = SinglyLinkedList.new
list.insert(1)
list.insert(2)
list.print
list.find_first { |node| node.value == 2 }

list2 = SinglyLinkedList.new
list2.insert(3)
list.cat(list2)

list.remove(Node.new(2))
list.clear
