#enter the workout for the day
def enter_workout(prompt, font)
    system "clear"
    puts font.write("Small Steps").colorize(:yellow) 
    puts "" 
    puts "Select the day that you wish to record a workout for. You will then be prompted to enter the number of repetitions you have completed for each exercise for the day.".colorize(:blue)
    puts ""
    
    #-------------------------------------------------------------ERROR HANDLING
    #Ruby function to check file existence
    if(File.file?("./saves/Exercise.txt")) 
    
        array = []
        #check which day it is
        day = prompt.select("What day is it?".light_cyan, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"])
        
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
            answer = prompt.ask("How many #{i} did you do today: ".colorize(:light_cyan) + "0-300?".colorize(:blue)) { |q| q.in("0-300") }
            #fills an array
            array << answer.to_i
        end

        #create a file to save the data for this day with the nameof the day as the file name
        File.open("./saves/#{day}.txt", "w") do |f|
            array.each { |element| f.puts(element) }
        end  
    
    else
        #if the exercise.txt file is missing the function cannot be used and user should be directed to the enter goals function to create one  
        puts "Exercise.txt file not found.".colorize(:yellow)
        puts ""
        puts ""
        puts "Please set your exercise goals for the week before entering a workout for a day.".colorize(:light_cyan) 
    end
end