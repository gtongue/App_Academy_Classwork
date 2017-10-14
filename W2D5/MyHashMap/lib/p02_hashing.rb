require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end


class String
  def hash
    string = ""
    self.each_byte do |c|
      string += c.to_s
    end
    string.to_i.hash
  end
end

class Array
  def hash
    string = ""
    self.each do |el|
      el = el.hash unless el.is_a?(Fixnum)
      string += el.to_s
    end
    string.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_add = 0
    to_a.sort.each do |key_val|
      hash_add += key_val.hash
    end
    hash_add.hash
  end
end
