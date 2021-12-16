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
#I should maybe replace these day arrays with a hash? keys are days and values are arrays of reps
#I would also need a goal hash with the key goal and an array of reps numbers
mon = []
tue = []
wed = []
thu = []
fri = []


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
def enter_workout(exercises)
    system = "clear"
    array = []
    
    #loops through exercises and for each displays the prompt below
    exercises.each do |i|
        #prompt the user for the number of repetitions done today for an exercise. Displays error message if number not between 1 and 100
        answer = $prompt.ask("How many #{i} did you do today: ".colorize(:light_cyan) + "1-100?".colorize(:blue)) { |q| q.in("1-100") }
        #fills an array
        array << answer.to_i
    end
    return array
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

        
        
    when "Enter today's workout"
        #check which day it is
        day = $prompt.select("What day is it?".light_cyan, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"])
        case day
        when "Monday"
            mon = enter_workout(target_exercises)   
        when "Tuesday"
            tue = enter_workout(target_exercises)  
        when "Wednesday"
            wed = enter_workout(target_exercises)  
        when "Thursday"
            thu = enter_workout(target_exercises)  
        when "Friday"
            fri = enter_workout(target_exercises)  
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