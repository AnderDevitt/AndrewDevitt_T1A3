#selects the exercises the user wants to do and sets their target repetitions
def select_exercises
    system "clear"
    puts font.write("Small Steps").colorize(:yellow) 
    puts "" 
    puts "Select the exercises"
    puts ""
    #Ask the user whether they wish to delete save files to begin a new week. If they choose no, they can overwrite the exercises and goals, but workout files will remain.
    delete = false
    delete = $prompt.yes?("Would you like to delete the save data and start a new week?")
    if delete == true
        #delete old save files so no old data is carried into a new week
        FileUtils.rm_rf(Dir['./saves/*'])
    end

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
        #-------------------------------------------------------------ERROR HANDLING is included in the prompt
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