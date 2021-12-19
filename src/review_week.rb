def review_week
    system "clear"
    puts $font.write("Small Steps").colorize(:yellow) 
        puts "" 
        puts "Well done! Below are the results of your workouts this week.".colorize(:blue)
        puts ""
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
    #end of code to transpose the arrays

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
        #I have used colorize the make the column headings green    
        puts "| #{ @columns.map { |_,g| g[:label].ljust(g[:width]) }.join(' | ') } |".colorize(:green)
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
    #end of table code
end
