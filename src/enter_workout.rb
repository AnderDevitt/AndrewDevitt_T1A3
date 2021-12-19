#enter the workout for the day
def enter_workout()
    system "clear"
    puts font.write("Small Steps").colorize(:yellow) 
        puts "" 
        puts "Welcome to the Small Steps workout motivator."
        puts ""
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
        #-------------------------------------------------------------ERROR HANDLING is included in the prompt
        #prompt the user for the number of repetitions done today for an exercise. Displays error message if number not between 1 and 100
        answer = $prompt.ask("How many #{i} did you do today: ".colorize(:light_cyan) + "1-100?".colorize(:blue)) { |q| q.in("1-100") }
        #fills an array
        array << answer.to_i
    end

    #create a file to save the data for this day with the nameof the day as the file name
    File.open("./saves/#{day}.txt", "w") do |f|
        array.each { |element| f.puts(element) }
    end  
end