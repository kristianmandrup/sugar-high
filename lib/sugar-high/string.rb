require 'sugar-high/array'

class String
  def self.random_letters count, type = :lower
   letters(type).pick(count)
  end

  def self.letters type = :lower
    letters = ('a'..'z').to_a
    type == :upper ? letters.map!(&:upcase) : letters
  end

  def trim
    self.strip
  end unless "".respond_to? :trim


  def concats *args
    args.inject(self) do |res, arg|
      res << arg.to_s
      res
    end
  end unless "".respond_to? :concats

  # remove prefixed '-' signs, then allow any letter, number, underscore '_' or dash '-'
  def alpha_numeric
    self.gsub(/^\-+/, '').gsub(/[^0-9a-zA-Z_\-]+/i, '')
  end

  def insert_before_last str, marker = 'end'
    res = []
    found = false
    marker = case marker
    when Symbol, String
      marker.to_s
    when Hash
      marker[:marker].to_s
    else
      raise ArgumentException, "last argument is the marker and must be a String, Symbol or even Hash with a :marker option pointing to the marker (String or Symbol)"
    end

    marker = Regexp.escape(marker.to_s.reverse)
    nl = Regexp.escape("\n")
    self.reverse.each_line do |x|
      x.gsub! /#{nl}/, ''
      if !found && x =~ /#{marker}/
        replace = "#{str}\n" << x.reverse
        res << replace
        found = true
      else
        res << x.reverse
      end
    end
    res = res.reverse.join("\n")
  end
end
