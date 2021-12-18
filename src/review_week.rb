def review_week
    array = []
    #get the names of files in the save directory
    #array = Dir[ './saves/*' ].select{ |f| File.file? f }.map{ |f| File.basename f }
    #print array

    arr = [{Ex: "Pushups", Go: "15", Mon: "9", Tue: "9", Wed: "10", Thu: "13", Fri: "15"},
        {Ex: "Situps", Go: "20", Mon: "20", Tue: "20", Wed: "20", Thu: "20", Fri: "20"},
        {Ex: "Leg-raises", Go: "20", Mon: "18", Tue: "15", Wed: "20", Thu: "23", Fri: "20"}]
        
        # arr = [{Ex: "Pushups", Go: "15".colorize(:yellow), Mon: "9", Tue: "9", Wed: "10", Thu: "13", Fri: "15"},
        #     {Ex: "Situps", Go: "20".colorize(:yellow), Mon: "20", Tue: "20", Wed: "20", Thu: "20", Fri: "20"},
        #     {Ex: "Leg-raises", Go: "20".colorize(:yellow), Mon: "18", Tue: "15", Wed: "20", Thu: "23", Fri: "20"}]
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