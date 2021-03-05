require 'pry'

class TicTacToe

    attr_accessor :board

    def initialize
        @board = Array.new(9, " ")
        board = @board
    end

    WIN_COMBINATIONS = 
    [
        [0, 1, 2], #top row
        [3, 4, 5], #middle row
        [6, 7, 8], #last row

        [0, 3, 6], #first column
        [1, 4, 7], #second column
        [2, 5, 8], #last column

        [0, 4, 8], #diagonal
        [2, 4, 6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        (@board[index] == "X" || @board[index] == "O")
    end

    def valid_move?(position)
        position.between?(0, 8) && !position_taken?(position)
    end

    def turn_count
        number_of_turns = 0

        @board.each do |space|
            if space == "X" || space == "O"
                number_of_turns += 1
            end
        end
        number_of_turns    
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    def turn
        puts "Please enter 1-9:"
        user_input = gets.chomp
        index = input_to_index(user_input)
        char = current_player

        if valid_move?(index)
            move(index, char)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |element|
            pos1 = @board[element[0]]
            pos2 = @board[element[1]]
            pos3 = @board[element[2]]

            if (pos1 == "X" && pos2 == "X" && pos3 == "X") || (pos1 == "O" && pos2 == "O" && pos3 == "O")
                return element
            end
        end
        false
    end

    def full?
        @board.all? {|occupied| occupied != " "}
    end

    def draw?
        !(won?) && (full?)
    end

    def over?
        full? || won? || draw?
    end

    def winner
        if won?
            array = won?
            winning = @board[array[0]]
            winning
        else
            nil
        end
    end

    def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end