require "tty-prompt"
require "colorize"

#define variables
$prompt = TTY::Prompt.new

#shows the main menu and returns the selected option
def select_main_menu
    answer = $prompt.select("What would you like to do today?", ["Weekly goals", "Enter today's workout", "Check progress", "Review the week", "Exit"])
    return answer
end

#show the list of skills and return the users skills
def select_exercises
    answer = $prompt.multi_select("Select the three exercises for this week.", ["Pushups", "Tricep presses", "Situps", "Crunches", "Legraises", "Lunges", "Squats"])
    return answer
end

def set_reps(goals)
    array = []
    goals.each do |i|
        #print "How many #{i} will you do? "
        #array << gets.chomp.to_i
        answer = $prompt.ask("How many #{i} will you do: 0-100?") { |q| q.in("0-100") }
        array << answer
        #puts array
    end
end

system "clear"
puts "Welcome to Small Steps workout motivator."


option = ""
goals = []
reps =[]
while option != "Exit"
    #invokes the menu and stores the option in the variable
    option = select_main_menu
    #case statement to handle the options of the menu
    case option
    when "Weekly goals"
        puts "Weekly goals selected"
        goals = select_exercises
        puts goals
        reps = set_reps(goals)
        puts reps
        #puts array
    when "Enter today's workout"
        puts "Entering the workout"
    when "Check progress"
        puts"This week so far"
    when "Review the week"
        puts "congratulations!"
    else
        puts "See you next time..."    
        #skip the rest of the iteration and return to the top of the while loop
        next
    end
    #this will stop the menu from appearing straight away after responding to an option choice
    print "Press Enter key to continue..."
    gets
    system "clear"

end