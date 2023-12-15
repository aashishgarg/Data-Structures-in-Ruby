require 'byebug'
class Node
  attr_accessor :value, :next, :prev

  def initialize(value)
    self.value = value
    self.next = nil
  end
end

class DoublyLinkedList
  attr_accessor :head, :tail, :length

  def initialize
    self.head = nil
    self.tail = nil
    self.length = 0
  end

  def insert(node)
    if self.head.nil?
      self.head = node
    else
      node.prev = self.tail
      self.tail.next = node
    end
    self.tail = node
    self.length += 1
  end

  def remove(node)
    return nil if node.nil?

    if node == head
      if head.next.nil?
        self.head = self.tail = nil
      else
        self.head = self.head.next
      end
    else
      tmp = self.head
      while tmp && tmp.next != node
        tmp = tmp.next
      end

      p = tmp.prev
      n = tmp.next
      p&.next = n
      n&.prev = p
    end
    self.length -= 1
  end

  def cat(list)
    return nil unless list

    list.head.prev = self.tail
    self.tail.next = list.head
    self.tail = list.tail
    self.length += list.length
  end

  def find_last(&predicate)
    return nil unless block_given?

    current = self.tail
    while current
      return current if predicate.call(current)
      current = current.prev
    end
  end

  def reverse_each
    return nil unless block_given?
    current = self.tail
    while current
      yield current
      current = current.prev
    end
  end

  def reverse_print
    if self.length == 0
      puts "empty"
    else
      self.reverse_each { |item| puts item.value }
    end
  end

  def clear
    self.head = self.tail = nil
    self.length = 0
  end
end

list = DoublyLinkedList.new
n1 = Node.new 1
n2 = Node.new 2
n3 = Node.new 3
list.insert n1
list.insert n2
list.insert n3

list.reverse_print
list.find_last { |x| x.value == 2 }
list.remove n2

list2 = DoublyLinkedList.new
list2.insert Node.new(4)
list2.insert Node.new(5)
list.cat list2
puts list.length
