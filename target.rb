class Target 
    attr_reader :target_exercises, :target_reps

    def initialize(target_items, target_reps)
        @target_exercises = target_exercises
        @target_reps = target_reps
    end

    def show_goals
        puts "This week's goals: "
        @target_exercises.each {|exercise| puts exercise}
        @target_reps.each {|reps| puts reps}
    end

    
end