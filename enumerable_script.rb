#!/usr/bin/ruby

module Enumerable
  
  puts "Hello World!"

  def my_each
    i=0
    while self[i]
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    i=0
    while self[i]
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    i = 0
    while self[i]
      if yield self[i]
        result << self[i]
      end
      i += 1
    end
    result
  end

  def my_all?
    self.my_each do |i| 
      return false unless yield(i)
    end
    return true
  end

  def my_any?
    self.my_each do |i| 
      return true unless !yield(i)
    end
    return false
  end

  def my_none?
    self.my_each do |i|
      return false unless !yield(i)
    end
    return true
  end

  def my_count (arg=0)
    if block_given?
      self.my_select {|i| yield(i)}.length
    elsif arg != 0
      self.my_select {|i| i == arg}.length
    else
      self.length
    end
  end

  def my_map
    result = []
    i = 0
    while self[i]
      result << yield(self[i])
      i += 1      
    end
    result    
  end

  def my_map_proc(proc)
    result = []
    i = 0
    while self[i]
      result << proc.call(i)
    end
    result
  end

  def my_inject (memo=0)
    self.my_each do |i|
      memo = yield(memo, i)
    end
    memo
  end


end


def multiply_els(arr)
    total = arr.my_inject(1) {|total, element| total * element}
  end