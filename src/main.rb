require "tty-prompt"
require "colorize"
require "tty-font"
require 'fileutils'
require 'tty-table'
require "pp"

require_relative "./select_exercises.rb"
require_relative "./enter_workout.rb"
require_relative "./review_week.rb"
require_relative "./main_menu.rb"

#define variables
#currently I need this prompt to be a global variable to save me calling multiple prompt instances
prompt = TTY::Prompt.new
#give me a cool font for style
font = TTY::Font.new(:doom)

#accept and handle command line arguments
# Allows for quick access to individual functions without running the whole program
if ARGV[0] == "goals"
    select_exercises()
elsif ARGV[0] == "workout"
    enter_workout()
elsif ARGV[0] == "results"
    review_week()
else
    #display the main menu and program operation as usual
    option = ""
    while option != "Exit"
        #display app heading and greeting on every screen
        system "clear"
        puts font.write("Small Steps").colorize(:yellow) 
        puts "" 
        puts "Welcome to the Small Steps workout motivator. Our goal is to help you to begin your exercise journey with small, manageable goals that you can track and attain each week. - Best of luck!".colorize(:blue)
        puts ""

        #invokes the menu and stores the option in the variable
        option = main_menu(prompt)

        #case statement to handle the options of the menu
        case option
            when "Set my goals"
                #call a function to choose exercises and target repetitions
                select_exercises(prompt, font)
            when "Enter today's workout"
                #-------------------------------------------------------------ERROR HANDLING
                #Ruby function to check file existence
                if(File.file?("./saves/Exercise.txt")) 
                    #call a function to enter the day and reps completed
                    enter_workout(prompt, font)
                else
                    #if the exercise.txt file is missing the function cannot be used and user should be directed to the enter goals function to create one  
                    puts "Exercise.txt file not found.".colorize(:yellow)
                    puts ""
                    puts ""
                    puts "Please set your exercise goals for the week before entering a workout for a day.".colorize(:light_cyan) 
                end
            when "Review the week"
                #-------------------------------------------------------------ERROR HANDLING
                #Ruby function to check file existence
                if(File.file?("./saves/Exercise.txt")) 
                    #call a function to display all data for the week in a table
                    review_week(font)
                else
                    #if the exercise.txt file is missing the function cannot be used  
                    puts ""
                    puts ""
                    puts "Exercise.txt file not found.".colorize(:yellow)
                    puts ""
                    puts ""
                    puts "You cannot review the week without having set your exercises and goals".colorize(:light_cyan)
                    puts "Please set your goals to continue".colorize(:light_cyan) 
                end    
            else   
                system "clear"
                puts "See you next time..."  
                puts ""
                puts ""  
            next
        end
        #stop the menu from appearing straight away after responding to an option choice
        puts ""
        puts ""
        print "Press any key to continue..."
        STDIN.getch
        system "clear"
    end
end