class LinkedList

  class Node
    attr_accessor :prev_node
    attr_accessor :next_node
    attr_accessor :data

    def initialize(data)
      @data = data
      @prev_node = nil
      @next_node = nil
    end

    def inspect
      "Node[Data = #{@data}, next_node == false: #{@next_node == nil}, prev_node == false: #{@prev_node == nil}]"
    end
  end

  def initialize
    @head = nil
    @tail = nil
    @current = nil
  end

  def head_node
    @head
  end

  def tail_node
    @tail
  end

  def add(obj)
    node = Node.new(obj)

    if @head == nil
      @head = node
      reset
    elsif @tail == nil
      @tail = node
      @tail.prev_node = @head
      @head.next_node = @tail
    else
      @tail.next_node = node
      node.prev_node = @tail
      @tail = node
    end
  end

  def remove
    raise 'list is empty' if empty?

    if @tail == nil
      unshift
      return
    end

    @tail = @tail.prev_node
    @tail.next_node = nil
  end

  def unshift
    raise 'list is empty' if empty?

    unless @head.next_node == nil
      @head.next_node.prev_node = nil
    end
    @head = @head.next_node
  end

  def remove_at(index)
    if index == 0
      unshift
      return
    end
    if index+1 == length
      remove
      return
    end

    node = get_node(index)
    unless node.next_node == nil
      node.next_node.prev_node = node.prev_node
    end
    unless node.prev_node == nil
      node.prev_node.next_node = node.next_node
    end
  end

  def insert(obj, index)
    raise 'index out of bounds' if index >= length

    node = Node.new(obj)
    cur_index = 0
    curr = @head
    until cur_index == index
      curr = curr.next_node
      cur_index += 1
    end

    curr.prev_node.next_node = node
    node.prev_node = curr.prev_node
    node.next_node = curr
    curr.prev_node = node
  end

  def get_node(index)
    raise 'index out of bounds' if index >= length

    if index == 0
      head_node
    end

    elements = []
    each_node {|item| elements << item}

    elements[index]
  end

  def get(index)
    get_node(index).data
  end

  def next
    raise 'End of list' if @current.next_node == nil
    @current = @current.next_node
  end

  def previous
    raise 'Start of list' if @current.prev_node == nil
    @current = @current.prev_node
  end

  def current_data
    @current.data
  end

  def head
    raise 'List is empty' if empty?
    @head.data
  end

  def tail
    raise 'List is empty' if empty?
    raise 'List has only a single element' if @tail == nil
    @tail.data
  end

  def length
    length = 0
    each do
      length += 1
    end
    length
  end

  def empty?
    @head == nil
  end

  def reset
    @current = @head
  end

  def inspect
    ret_str = 'LinkedList['
    each {|item| ret_str = "#{ret_str}#{item}, "}
    ret_str.chomp(', ') + ']'
  end

  def each_node
    curr = @head
    until curr == nil
      yield(curr)
      curr = curr.next_node
    end
  end

  def each
    each_node {|node| yield(node.data)}
  end
end
