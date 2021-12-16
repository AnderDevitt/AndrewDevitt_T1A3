require "tty-prompt"
require "colorize"
require "tty-font"
#require_relative "./target.rb"
#require_relative "./functions.rb"

#define variables
$prompt = TTY::Prompt.new
#give me a cool font for style
font = TTY::Font.new(:doom)
#variables for user goals
target_exercises = [] 
target_reps =[]         


#shows the main menu and returns the selected option
def select_main_menu
    puts ""
    answer = $prompt.select("What would you like to do today?".colorize(:light_cyan), ["Set my goals", "Enter today's workout", "Review the week", "Exit"])
    return answer
end

#selects the exercises the user wants to do
def select_exercises
    #space 
    puts ""

    #display a multiple-choice menu of exercises and saves choices to a file
    exercise = $prompt.multi_select("Select the three exercises for this week.".colorize(:light_cyan), ["Pushups", "Tricep pressess", "Situps", "Crunches", "Leg-raises", "Lunges", "Squats"])
    #create a file to store an array for exercises
    File.open("./saves/exercises.txt", "w") do |f|
        exercise.each { |element| f.puts(element) }
    end

    #sets the number of repetitions the user will aim to do each day and saves in a file
    array = []
    #loops through selected exercises and for each displays the prompt below
    exercise.each do |i|
        puts ""
        #prompt the user for the number of repetitions for an exercise. Displays error message if number not between 1 and 100
        reps = $prompt.ask("How many #{i} will you do each day: ".colorize(:light_cyan) + "1-100?".colorize(:blue)) { |q| q.in("1-100") }
        #fills an array
        array << reps.to_i
    end
    #create a file to store an array for target repetitions
    File.open("./saves/targets.txt", "w") do |f|
        array.each { |element| f.puts(element) }
    end
end

#enter the workout for the day
def enter_workout()
    system = "clear"
    array = []
    
    #check which day it is
    day = $prompt.select("What day is it?".light_cyan, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"])

    #open the exercises file and read the exercises into an array
    file = File.open("./saves/exercises.txt")
    exercises_array=[] # start with an empty array
    file.each_line {|line|
        exercises_array.push line
    }

    #loops through exercises and for each displays the prompt below
    exercises_array.each do |i|
        puts ""
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
    array = []
    #get the names of files in the save directory
    #array = Dir[ './saves/*' ].select{ |f| File.file? f }.map{ |f| File.basename f }
    #print array

    arr = [{Ex: "ex1", Go: "20", Mon: "3", Tue: "3", Wed: "3", Thu: "3", Fri: "3"},
        {Ex: "ex2", Go: "12", Mon: "12", Tue: "12", Wed: "12", Thu: "12", Fri: "12"},
        {Ex: "ex3", Go: "4", Mon: "4", Tue: "5", Wed: "5", Thu: "5", Fri: "5"}]
        
    #FOLLOWING 30 LINES TO CREATE A TABLE FROM: https://stackoverflow.com/questions/28684598/print-an-array-into-a-table-in-ruby
    col_labels = { Ex: "Exercises", Go: "My Goals", Mon: "Monday", Tue: "Tuesday", Wed: "Wednesday", Thu: "Thursday", Fri: "Friday" }

        @columns = col_labels.each_with_object({}) { |(col,label),h|
            h[col] = { label: label,
                       width: [arr.map { |g| g[col].size }.max, label.size].max } }
          
          def write_header
            puts "| #{ @columns.map { |_,g| g[:label].ljust(g[:width]) }.join(' | ') } |"
          end
          
          def write_divider
            puts "+-#{ @columns.map { |_,g| "-"*g[:width] }.join("-+-") }-+"
          end
          
          def write_line(h)
            str = h.keys.map { |k| h[k].ljust(@columns[k][:width]) }.join(" | ")
            puts "| #{str} |"
          end

        write_divider
        write_header
        write_divider
        arr.each { |h| write_line(h) }
        write_divider

    #open the exercises file and read the exercises into an array
    # file = File.open("./saves/exercises.txt")
    # exercises_array=[] # start with an empty array
    # file.each_line {|line|
    #     exercises_array.push line
    # }
    # #open the targets file and read the exercises into an array
    # file = File.open("./saves/targets.txt")
    # targets_array=[] # start with an empty array
    # file.each_line {|line|
    #     targets_array.push line
    # }


end

#option = "Set my goals" if ARGV[0] == "goals"
#option = "Enter today's workout" if ARGV[0] == "workout"

option = ""
while option != "Exit"

    #display app heading and greeting on every screen
    system "clear"
    puts font.write("Small Steps")
    puts "" 
    puts "Welcome to the Small Steps workout motivator."
    puts ""

    #invokes the menu and stores the option in the variable
    option = select_main_menu()
    #case statement to handle the options of the menu
    case option
    when "Set my goals"
        #call a function to choose exercises and target repetitions
        select_exercises()
    when "Enter today's workout"
        #call a function to enter the day and reps completed
        enter_workout()
    when "Review the week"
        #call a function to display all data for the week in a table
        review_week()
    else   
        system "clear"
        puts "See you next time..."    
        next
    end
    #stop the menu from appearing straight away after responding to an option choice
    puts ""
    puts ""
    print "Press Enter key to continue..."
    gets
    system "clear"
end