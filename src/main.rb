require "tty-prompt"
require "colorize"
require "tty-font"
#require_relative "./target.rb"


#define variables
$prompt = TTY::Prompt.new
font = TTY::Font.new(:doom)
#variables for user goals
target_exercises = [] 
target_reps =[]         



#shows the main menu and returns the selected option
def select_main_menu
    answer = $prompt.select("What would you like to do today?".colorize(:light_cyan), ["Set my goals", "Enter today's workout", "Review the week", "Exit"])
    return answer
end

#selects the exercises the user wants to do
def select_exercises
    system = "clear"
    #display a multiple-choice menu of exercises; space added to strings for formatting
    answer = $prompt.multi_select("Select the three exercises for this week.".colorize(:light_cyan), ["Pushups", "Tricep pressess", "Situps", "Crunches", "Leg-raises", "Lunges", "Squats"])
    return answer
end

#sets the number of repetitions the user will aim to do each day
def set_reps(goals)
    system = "clear"
    array = []
    #loops through selected exercises and for each displays the prompt below
    goals.each do |i|
        #prompt the user for the number of repetitions for an exercise. Displays error message if number not between 1 and 100
        answer = $prompt.ask("How many #{i} will you do each day: ".colorize(:light_cyan) + "1-100?".colorize(:blue)) { |q| q.in("1-100") }
        #fills an array
        array << answer.to_i
    end
    return array
end

#enter the workout for the day
def enter_workout(day, exercises)
    system = "clear"
    array = []
    
    #loops through exercises and for each displays the prompt below
    exercises.each do |i|
        #prompt the user for the number of repetitions done today for an exercise. Displays error message if number not between 1 and 100
        answer = $prompt.ask("How many #{i} did you do today: ".colorize(:light_cyan) + "1-100?".colorize(:blue)) { |q| q.in("1-100") }
        #fills an array
        array << answer.to_i
    end
    File.open("./saves/#{day}.txt", "w") do |f|
        array.each { |element| f.puts(element) }
    end
    #return array
end

def review_week
    puts "congratulations!"
end

system "clear"
puts font.write("Small Steps") 
puts "Welcome to the Small Steps workout motivator."


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