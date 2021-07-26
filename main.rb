require_relative 'lib/game.rb'
require 'yaml'
include Display

def start_game_input
    input = gets.chomp
    if input == 'n'
        puts "new game"
        input
    elsif input == 'l'
        loading_text
        input
    else
        game_start_input_error
        start_game_input
    end
end

def new_game(selection)
    if selection == 'n'
        return Game.new
    elsif selection == 'l'
        saves = Dir['saves/*']
        
        if saves.length == 0
            zero_saves_error
            return Game.new
        elsif saves.length == 1
            load_input(saves)
            return load_file(saves[0])
        else
            load_input(saves)
            return load_selection
        end
    end
end

def load_selection
    saves = Dir['saves/*']

    save_number = gets.chomp
    if save_number.to_s =~ /[^0-9]/ || saves[save_number.to_i].nil?
        invalid_load_error
        load_selection
    else
        loaded_save = load_file(saves[save_number.to_i])
        if loaded_save.class == Game
            return loaded_save
        else
            invalid_file_error(saves[save_number.to_i])
            return Game.new
        end
    end 
end

def save_game(game)
    Dir.mkdir('saves') unless Dir.exist?('saves')

    filename = "saves/game#{game.id}.yaml"

    File.open(filename, 'w') do |file|
        file.puts YAML::dump(game)
    end
end

def load_file(file_to_load)
    file = File.open(file_to_load, 'r')
    data = YAML.load(file)
end

def make_guess_input(game)
    special = /[^A-Za-z]/

    input = gets.chomp
    if input == ""
        invalid_guess_error
        make_guess_input(game)
    elsif input =~ special
        if input == "\/s"
            saving
            save_game(game)
            game_saved
            make_guess
        else
            invalid_guess_error
        end
        make_guess_input(game)
    else
        if game.guesses_made.any? {|guess| guess == input.downcase}
            repeat_guess_error
            make_guess_input(game)
        else
            return input.downcase
        end
    end
end

def play_again_input
    input = gets.chomp
    if input == 'y'
        return true
    elsif input == 'n'
        return false
    else
        play_again_input
    end 
end

new_instance
list_rules
program_running = true

# game loop start
while program_running
    game_start_selection
    start_selection = start_game_input
    current_game = new_game(start_selection)
    game_active = true
    
    # turn cycle start
    while game_active
        puts "\n#{current_game.guesses_made}\n"
        puts "\n#{current_game.hidden_word}\n"
        puts "\nRemaining guesses: #{current_game.guesses_left}"

        make_guess
        player_guess = make_guess_input(current_game)
        current_game.add_guess(player_guess)

        guess_check_result = current_game.check_guess(player_guess)
        current_game.reveal_letter(player_guess) if guess_check_result == true

        passed_win_check = current_game.win_check
        passed_lost_check = current_game.lost_check
        if passed_win_check || guess_check_result == "match"
            winner_winner
            game_active = false
        elsif passed_lost_check
            loser
            game_active = false
        else 
            next
        end
    end
    #turn cycle end

    puts "The word was: #{current_game.guess_word}"
    play_again?
    program_running = play_again_input
end
# game loop end

thanks_for_playing
