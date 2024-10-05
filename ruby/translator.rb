BRAILLE_ALPHABET = {
  "a" => "O.....", "b" => "O.O...", "c" => "OO....", "d" => "OO.O..", "e" => "O..O..",
  "f" => "OOO...", "g" => "OOOO..", "h" => "O.OO..", "i" => ".OO...", "j" => ".OOO..",
  "k" => "O...O.", "l" => "O.O.O.", "m" => "OO..O.", "n" => "OO.OO.", "o" => "O..OO.",
  "p" => "OOO.O.", "q" => "OOOOO.", "r" => "O.OOO.", "s" => ".OO.O.", "t" => ".OOOO.",
  "u" => "O...OO", "v" => "O.O.OO", "w" => ".OOO.O", "x" => "OO..OO", "y" => "OO.OOO",
  "z" => "O..OOO",
  "0" => ".OOO..", "1" => "O.....", "2" => "O.O...", "3" => "OO....", "4" => "OO.O..", 
  "5" => "O..O..", "6" => "OOO...", "7" => "OOOO..", "8" => "O.OO..", "9" => ".OO...",
  "capital" => ".....O",  
  "number" => ".O.OOO",   
  "space" => "......"     
}


def is_braille?(input)
  input.match?(/[O.]{6}/)
end


def english_to_braille(text)
  result = ""
  number_mode = false
  text.each_char do |char|
    if char == " "
      result += BRAILLE_ALPHABET["space"]
      number_mode = false
    elsif char =~ /[A-Z]/
      result += BRAILLE_ALPHABET["capital"] + BRAILLE_ALPHABET[char.downcase]
      number_mode = false
    elsif char =~ /[0-9]/
      if !number_mode
        result += BRAILLE_ALPHABET["number"]
        number_mode = true
      end
      result += BRAILLE_ALPHABET[char]
    else
      result += BRAILLE_ALPHABET[char]
      number_mode = false
    end
  end
  result
end



def braille_to_english(braille)
  result = ""
  capitalize_next = false
  number_mode = false

  braille.scan(/.{6}/).each do |symbol|
    if symbol == BRAILLE_ALPHABET["capital"]
      capitalize_next = true
    elsif symbol == BRAILLE_ALPHABET["number"]
      number_mode = true
    elsif symbol == BRAILLE_ALPHABET["space"]
      result += " "
    else
      char = BRAILLE_ALPHABET.key(symbol)
      if number_mode
        result += char
        number_mode = false if result[-1] == " "
      elsif capitalize_next
        result += char.upcase
        capitalize_next = false
      else
        result += char
      end
    end
  end
  result
end

def translator(input)
  if is_braille?(input)
    braille_to_english(input)
  else
    english_to_braille(input)
  end
end

input = ARGV.join(' ')
puts translator(input)

