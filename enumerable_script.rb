#!/usr/bin/ruby

module Enumerable
  
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
    self
  end
  
  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
    self
  end
  
  def my_select
    result = []
    self.my_each do |i|
      if yield(i)
        result << i
      end
    end
    result
  end
  
  def my_all?
    self.my_each do |e|
      if !yield(e)
        false
      else
        true
      end
    end
  end
  
  def my_any?
    self.my_each do |e|
      if yield(e)
        true
      else
        false
      end
    end
  end
  
  def my_none?
    self.my_each do |e|
      if yield(e)
        false
      else
        true
      end
    end
  end
  
  def my_count
    counter = 0
    if block_given?
      self.my_each do |e|
        if yield(e)
          counter += 1
        end
      end
      counter
    else                ## need third option if argument given (not block)
      self.length
    end
  end
  
  #my_map block
  def my_map
    result = []
    self.my_each do |e|
      result << yield(e)
    end
    result
  end
  
  # source: Jim Weir gist
  def my_inject(initial = nil)
    acc = initial
    self.my_each do |item|
      if acc.nil?
        acc = item
      else
        acc = yield(acc, item)
      end
    end
    acc
  end
# --------------------------------------------------
#
# def multiply_els(args)
#   args.my_inject {|memo, obj| memo * obj }
# end
#
#   --------------------------------------------------

  #my_map proc
  
  the_proc = Proc.new {|e| e * e}
  
  def my_map
    result = []
    self.my_each do |element|
      result << the_proc.call(element)
    end
    result
  end 

end