module Display
    #OnStart
    def new_instance
        puts "+---------------------------+"
        puts "| A Classic Game of Hangman |"
        puts "+---------------------------+"
    end

    def list_rules
        puts "\nRules:"
        puts "You have 12 guesses to get the word correct otherwise you lose!\n\n"
        puts "All guesses made will be displayed per round\n\n"
        puts "if the guess matches any letter in the word all matching instances of that letter will be displayed\n\n"
        puts "if a word is guessed every letter within the guessed word will count as an individual guess\n\n"
        puts "if a word is guessed the word must be an exact match else the guess will fail\n\n"
        puts "You may win by either guessing all the correct letters of the word or by guessing the correct word entirely\n\n"
    end

    #new game
    def game_start_selection
        line_break = "----------------------------------------------------"
        
        puts line_break
        puts "Input the corresponding letter to make a selection"
        puts line_break
        puts "Start New Game('n')\n"
        puts "\nLoad Game('l')\n:"
    end

    def game_start_input_error
        puts "\nERROR Invalid Selection: you must enter either 'l' or 'n': "
    end

    #loading
    def loading_text
        puts "loading saves..."
    end

    def zero_saves_error
        puts "loading failed: no saves to load from"
        puts "\nStarting new game..."
    end

    def load_input(saves)
        cur = 0

        puts "\nYou have #{saves.length} saves: "
        puts "\n"
        saves.each do |save|
            puts "#{cur} - #{save}"
            cur += 1
        end
        if saves.length == 1
            loading_save(saves[0])
        else
            puts "\nInput a number between 0 and #{saves.length - 1} to load the corresponding save file: "
        end
    end

    def loading_save(file)
        puts "\nloading save #{file}"
    end

    def invalid_load_error
        puts "\nERROR Invalid Selection: input must be a number that correspondes with one of the given save files"
        puts "\nTry again:"
    end

    def invalid_file_error(file)
        puts "\nERROR: '#{file}' is not a valid save file"
        puts "check 'saves/' directory to inspect save files"
        puts "\nstarting new game..."
    end

    #turn
    def make_guess
        puts "\n(warning: remember a word will cost as many guesses as the length of the word and must be an identical match)"
        puts "Input a letter or word to make a guess or '/s' to save: "
    end

    def invalid_guess_error
        puts "\nERROR: input cannot contain a number or symbol unless saving"
        puts "\nTry again: "
    end

    def repeat_guess_error
        puts "\nERROR: input cannot match a previous guess"
        puts "\nTry again: "
    end

    #save game
    def saving
        puts "\nSaving game..."
    end

    def game_saved
        puts "\nGame saved!"
    end

    #game end
    def winner_winner
        puts "\nCongratulation you won!\n"
    end

    def loser
        puts "\nSorry you lost!\n"
    end

    def play_again?
        puts "\nWould you like to play again? "
    end

    #end program
    def thanks_for_playing
        puts "\nThank you for playing!\n"
    end
end