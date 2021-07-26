class Game
    require_relative 'wordlist.rb'
    require_relative 'display.rb'

    include Display
    attr_reader :id, :hidden_word, :guesses_made, :guesses_left, :guess_word, :guesses_made

    def initialize
        new_word
        @hidden_word = hide_word(@guess_word.length)
        @guesses_made = []
        @guesses_left = 12
        @id = 5.times.map {rand(0..9)}.join
    end

    def new_word
        @guess_word = WordList.new.random_word.downcase
    end

    def hide_word(length)
        str = String.new
        str = str.rjust(length * 2, "_ ")
        return str
    end

    def add_guess(input)
        @guesses_made.push(input)
    end
    
    def reveal_letter(input)
        index_arr = (0...@guess_word.length).find_all {|i| @guess_word[i,1] == input}
        index_arr.each do |i|
            @hidden_word[i * 2] = input
        end
    end
    
    def check_guess(input)
        @guesses_left -= input.length

        if input.length > 1
            if input == @guess_word
                return "match"
            else
                return false
            end
        else
            if @guess_word.include?(input)
                return true
            else
                return false
            end
        end
    end

    def win_check
        return true if @hidden_word.split(" ").join == (@guess_word)
    end

    def lost_check
        return true if @guesses_left == 0 && @hidden_word.split(" ").join != (@guess_word)
    end
end