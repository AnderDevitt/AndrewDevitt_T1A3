require "tty-prompt"
require "colorize"
require "tty-font"
require 'fileutils'
require 'tty-table'
require "pp"
#require_relative "./target.rb"
#require_relative "./functions.rb"

#define variables
#currently I need this prompt to be a global variable to save me calling multiple prompt instances
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

#selects the exercises the user wants to do and sets their target repetitions
def select_exercises

    #delete old save files so no old data is carried into a new week
    FileUtils.rm_rf(Dir['./saves/*'])

    #space 
    puts ""

    #display a multiple-choice menu of exercises and saves choices to a file
    exercise = $prompt.multi_select("Select the exercises you would like to do this week.".colorize(:light_cyan), ["Pushups", "Tricep pressess", "Situps", "Crunches", "Leg-raises", "Lunges", "Squats"])
    #create a file to store an array for exercises
    File.open("./saves/Exercise.txt", "w") do |f|
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
    File.open("./saves/Goal.txt", "w") do |f|
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
    file = File.open("./saves/Exercise.txt")
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
    arr = []
    read_array =[]
    #get the names of files in the save directory
    file_array = Dir[ './saves/*' ].select{ |f| File.file? f }.map{ |f| File.basename f}
    sort_order = ["Exercise.txt", "Goal.txt", "Monday.txt", "Tuesday.txt", "Wednesday.txt", "Thursday.txt", "Friday.txt"]
    #sort the file_array to match sort_order array
    file_array = file_array.sort_by {|m| sort_order.index m}
    #headings = []
    headings = file_array.map{|i| i.chomp(".txt")}
    
    combined_hash ={}
    headings.each do |x|
    #open the exercises file and read the exercises into an array
    file = File.open("./saves/#{x}.txt")
    new_array=[] # start with an empty array
    file.each_line {|line|
        new_array.push line.chomp("\n")
    }
    read_array << new_array
    end
    transposed_arr = read_array.transpose()
    
     
    #make a hash of the arrays headings and columns
    #Code source used to learn how to do this 
    #https://medium.com/@alinaarakelyan/ruby-combing-two-arrays-into-a-hash-3d4f1c6bcf67
    final = []
    transposed_arr.each do |sub_array|
        sub_array.each do #|element|
        combined_hash = Hash[headings.zip(sub_array)]
        end    
        arr << combined_hash
      end
    
    puts""
    puts ""
    
    #make a hash for column labels from my headings array
    col_headings = {}
    headings.each do |i|
        col_headings[i] = i
    end
    
    #Turn my headings hash and array of hashes into a table for display
    #Code source that helped me work this out 
    #https://stackoverflow.com/questions/28684598/print-an-array-into-a-table-in-ruby
    @columns = col_headings.each_with_object({}) { |(col,label),h|
        h[col] = { label: label, width: [arr.map { |g| g[col].size }.max, label.size].max } }
            
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
end

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
        print "Press any key to continue..."
        STDIN.getch
        system "clear"
    end
end