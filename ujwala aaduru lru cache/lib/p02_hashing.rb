class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    final_hash = ''
    final_hash = self.map(&:to_s).join("")
    final_hash.hash
  end
end

class String
  def hash
    characters = self.chars
    final_hash = ''

    characters.each do |el|
      final_hash += el.ord.to_s
    end

    final_hash.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.keys.map(&:to_s).sort
    arr.hash
  end
end
