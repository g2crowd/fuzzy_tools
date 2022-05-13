module FuzzyTools
  module Helpers
    extend self

    def term_counts(enumerator)
      {}.tap do |counts|
        enumerator.each do |e|
          counts[e] ||= 0
          counts[e]  += 1
        end
      end
    end

    def bigrams(str)
      ngrams(str, 2)
    end

    def trigrams(str)
      ngrams(str, 3)
    end
    
    def tetragrams(str)
      ngrams(str, 4)
    end
  
    def ngrams(str, n)
      ends   = "_" * (n - 1)
      str    = "#{ends}#{str}#{ends}"
    
      (0..str.length - n).map { |i| str[i,n] }
    end

    SOUNDEX_LETTERS_TO_CODES = {
      'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 0, 'F' => 1,
      'G' => 2, 'H' => 0, 'I' => 0, 'J' => 2, 'K' => 2,
      'L' => 4, 'M' => 5, 'N' => 5, 'O' => 0, 'P' => 1,
      'Q' => 2, 'R' => 6, 'S' => 2, 'T' => 3, 'U' => 0,
      'V' => 1, 'W' => 0, 'X' => 2, 'Y' => 0, 'Z' => 2
    }


    def soundex(str)
      soundex = "Z000"
      chars = str.upcase.chars.to_a
      first_letter = chars.shift until (last_numeral = first_letter && SOUNDEX_LETTERS_TO_CODES[first_letter]) || chars.size == 0
      return soundex unless last_numeral
      soundex[0] = first_letter
      i = 1
      while i < 4 && chars.size > 0
        char = chars.shift
        next unless numeral = SOUNDEX_LETTERS_TO_CODES[char]
        if numeral != last_numeral
          last_numeral = numeral
          if numeral != 0
            soundex[i] = numeral.to_s
            i += 1
          end
        end
      end

      soundex
    end

  end
end