require "tty-prompt"
require "colorize"
require "tty-font"
#require_relative "./target.rb"
require_relative "./functions.rb"

#define variables
$prompt = TTY::Prompt.new
#give me a cool font for style
font = TTY::Font.new(:doom)
#variables for user goals
target_exercises = [] 
target_reps =[]         




system "clear"
puts font.write("Small Steps")
puts "" 
puts "Welcome to the Small Steps workout motivator."
puts ""


option = ""
while option != "Exit"
    #invokes the menu and stores the option in the variable
    option = select_main_menu

    #case statement to handle the options of the menu
    case option
    when "Set my goals"
        #get user exercise choices from function
        target_exercises = select_exercises
        #get number of repetitions user will aim for from function
        target_reps = set_reps(target_exercises)

        #create a file to store an array for exercises
        File.open("./saves/exercises.txt", "w") do |f|
            target_exercises.each { |element| f.puts(element) }
        end
        #create a file to store an array for target repetitions
        File.open("./saves/targets.txt", "w") do |f|
            target_reps.each { |element| f.puts(element) }
        end

    when "Enter today's workout"
        # a blank array to hold return from enter_workout function
        reps_array = []

        #open the exercises file and read the exercises into an array
        file = File.open("./saves/exercises.txt")
        exercises_array=[] # start with an empty array
        file.each_line {|line|
            exercises_array.push line
        }

        #check which day it is
        day = $prompt.select("What day is it?".light_cyan, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])
        
        #for each day, pass the exercises_array to the function, return the value to a temporary array, and write the data to a file for that day
        case day
        when "Monday"
            reps_array = enter_workout("mon", exercises_array)    
        when "Tuesday"
            reps_array = enter_workout("tue", exercises_array) 
        when "Wednesday"
            reps_array = enter_workout("wed", exercises_array)  
        when "Thursday"
            reps_array = enter_workout("thu", exercises_array)   
        when "Friday"
            reps_array = enter_workout("fri", exercises_array) 
        end

    when "Review the week"
        review_week()
    else   
        system "clear"
        puts "See you next time..."    
        next
    end
    #stop the menu from appearing straight away after responding to an option choice
    print "Press Enter key to continue..."
    gets
    system "clear"

end