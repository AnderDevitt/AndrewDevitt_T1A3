require "tty-prompt"
require "colorize"
require "tty-font"
require 'fileutils'


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
    select_exercises(prompt, font)
elsif ARGV[0] == "workout"
    enter_workout(prompt, font)
elsif ARGV[0] == "results"
    review_week(font)
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
                #call a function to enter the day and reps completed
                enter_workout(prompt, font)
            when "Review the week"
                #call a function to display all data for the week in a table
                review_week(font)
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
        print "Press any key to continue...".colorize(:yellow)
        STDIN.getch
        system "clear"
    end
end