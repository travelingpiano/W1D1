class Array
  def my_each(&prc)
    for i in (0..self.length-1)
      prc.call(self[i])
    end
    self
  end

  def my_select(&prc)
    newarr = []
    for i in (0..self.length-1)
      newarr << self[i] if prc.call(self[i])
    end

    newarr
  end

  def my_reject(&prc)
    newarr = []
    for i in (0..self.length-1)
      newarr << self[i] unless prc.call(self[i])
    end

    newarr
  end

  def my_any?(&prc)
    self.each do |ele|
      return true if prc.call(ele)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |ele|
      return false unless prc.call(ele)
    end
    true
  end

  def my_flatten

    newarr = []
    #check self depth
    self.each do |ele|
      if ele.kind_of?(Array)
        newarr += ele.my_flatten
      else
        newarr << ele
      end
    end
    newarr
  end

  def my_zip(*args)
    newarr = []
    puts args
    self.each_index do |idx|
      tmp = [self[idx]]
      (0...args.length).each do |ele|
        tmp << args[ele][idx]
      end
      newarr << tmp
    end
    newarr
  end

  def my_rotate(num = 1)
    if num > 0
      self.push(self.shift(num%4))
    else
      self.unshift(self.pop(num%4))
    end
    self
  end

  def my_join(charz="")
    ans = ""
    self.each do |ele|
      ans << ele + charz
    end
    return ans[0...-1] unless charz == ""
    ans
  end

  def my_reverse
    newarr = []
    self.each do |ele|
      newarr.unshift(ele)
    end
    newarr
  end

  def bubble_sort!(&prc)
    self.each_index do |idx|
      self.each_index do |idx2|
        if idx2 > idx
          self[idx], self[idx2] = self[idx2], self[idx] if prc.call(self[idx2], self[idx])
        end
      end
    end

  end

end

a = [1,3,2,4,1]

puts a.bubble_sort!{|num1,num2| num1 > num2}

# ans = [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
# puts ans.all?{|ele| !ele.is_a? Array}
# puts ans == [1, 2, 3, 4, 5, 6, 7, 8]
# puts ans
#
# puts [1,[2,3]].my_flatten == [1,2,3]
