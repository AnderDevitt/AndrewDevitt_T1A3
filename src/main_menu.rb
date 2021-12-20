#shows the main menu and returns the selected option
def main_menu(prompt)
    puts ""
    puts "Select " + "Set my goals".colorize(:green) + " to choose the exercises and number of repetitions you want to do each day this week."
    puts "Select " + "Enter today's workout".colorize(:green) + " to enter the number of reps you did for each exercise on a day." 
    puts "Select " + "Review the week".colorize(:green) + " to see your results for each day of training compared to your goals."
    puts ""
    puts ""
    answer = prompt.select("What would you like to do today?".colorize(:light_cyan), ["Set my goals", "Enter today's workout", "Review the week", "Exit"])
    return answer
end