class WordList
    require 'csv'
    
    def initialize
        words = CSV.open('5desk.txt')
        @wordlist = []
        words.each do |item|
            word = item.to_s[2..item.to_s.length - 3]
            @wordlist.push(word) unless word.length < 5 || word.length > 12
        end
    end

    def access_list
        @wordlist
    end

    def random_word
       @wordlist.sample 
    end
end