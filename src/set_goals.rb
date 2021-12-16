
#variables
#$prompt = TTY::Prompt.new

#selects the exercises the user wants to do
def select_exercises
    #system = "clear"
    puts ""
    #display a multiple-choice menu of exercises; space added to strings for formatting
    answer = $prompt.multi_select("Select the three exercises for this week.".colorize(:light_cyan), ["Pushups", "Tricep pressess", "Situps", "Crunches", "Leg-raises", "Lunges", "Squats"])
    return answer
end

#sets the number of repetitions the user will aim to do each day
def set_reps(goals)
    #system = "clear"
    array = []
    #loops through selected exercises and for each displays the prompt below
    goals.each do |i|
        puts ""
        #prompt the user for the number of repetitions for an exercise. Displays error message if number not between 1 and 100
        answer = $prompt.ask("How many #{i} will you do each day: ".colorize(:light_cyan) + "1-100?".colorize(:blue)) { |q| q.in("1-100") }
        #fills an array
        array << answer.to_i
    end
    return array
end