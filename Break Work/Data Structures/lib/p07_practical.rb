require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  map = HashMap.new()
  string.each_char do |char| 
    val = map.get(char)
    if val
      map.set(char, val + 1)
    else
      map.set(char, 1)
    end
  end
  found_odd = false
  map.each do |key, val|
    if val.odd? && !found_odd
      found_odd = true
    elsif val.odd? && found_odd
      return false
    end
  end
  return true
end