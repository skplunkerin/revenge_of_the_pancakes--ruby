# See README.md for example bash calls

class FlipPancakes
  
  # Setup class and run initial validations
  def initialize(init={})
    # We need test cases && pancake stacks in order to run our logic
    raise ArgumentError, "Tests && Stacks required!" if !init[:tests] && !init[:stacks]

    # Set our test cases && pancake stacks
    @test_cases = init[:tests].to_i
    @pancake_stacks = init[:stacks]

    # VALIDATIONS:
    # 1. Test cases must be between 1..100
    raise ArgumentError, "Test cases must be greater than 0, and less than 101" if @test_cases < 1 || @test_cases > 100

    # 2. Pancake stacks must only contain pluses (+) and minuses (-)
    raise ArgumentError, "Stacks had invalid characters: #{/[^+-]/.match(@pancake_stacks.join)}" if !/[^+-]/.match(@pancake_stacks.join).nil?

    # 3. Individual pancake stacks must be between 1..100
    # Create array of the length of each stack then
    # check if each stack length is between 1..100
    raise ArgumentError, "Stack lengths must be greater than 0, and less than 101" if @pancake_stacks.map{|s| s.length}.any?{|count| count < 1 || count > 100}

    # 4. If we have more or less stacks than test cases
    raise ArgumentError, "Test cases (count: #{@test_cases}) doesn't match pancake stacks (count: #{@pancake_stacks.length})" if @pancake_stacks.length > @test_cases || @pancake_stacks.length < @test_cases

  end
  
  # Process each pancake stack
  def process_stacks
    case_num = 1

    # Run through each test
    @pancake_stacks.each do |stack|
      # Initial state of stack
      # puts "Case #{case_num} stack:"
      # puts stack
      flips = flip_faceup(stack)
      puts "Case ##{case_num}: #{flips[:steps]}"
      # New state of stack
      # puts 'New stack:'
      # puts flips[:stack]
      case_num += 1
      # Breaker
      # puts "========================"
    end

  end

  private

  # Process pancake "stack", flipping all stacks face-up
  def flip_faceup(stack)
    steps = 0 # Number of steps to get all pancakes happy
    group_start = 0 # Always 0
    group_end = -1 # Begins at last pancake, goes up to find last un-happy pancake
    # Only begin loop if we have un-happy pancakes
    if stack.include?('-')
      begin
        # Rule #2: Never flip un-happy bottom pancake to another un-happy pancake
        # Rule #4: Never unflip *ANY* happy bottom pancakes
        # Find the last un-happy pancake, and never touch bottom happy pancakes
        group_end = stack.rindex('-') # Completed Rule #4. Continue -->

        # Rule #1, turn bottom cake happy ASAP
        # Rule #3: If first & last pancakes are un-happy, flip the full stack
        if stack[-1] == '-'
          if stack[0] == '-'
            # Flip full stack
            stack = flip_substack(stack)
          else
            # Rule #5: Always end group with same symbol as top pancake
            #           OR only flip top pancake
            #           BOTH will have the same amount of steps
            stack = flip_substack(stack[0]) + stack[1..-1]
          end
        else
          # Rule #5: Always end group with same symbol as top pancake
          #           OR only flip top pancake
          #           BOTH will have the same amount of steps
          if stack[0] == '-'
            # Flip first, to last un-happy pancake
            stack = flip_substack(stack[0..group_end]) + stack[group_end+1..-1]
          else
            # Get the "+" begin/end group to flip (ignoreing the last found +'s)
            #   [+...+]-+
            #           ^ ignore
            #   [+...+]++
            #          ^^ NOPE, we ignore this rule now
            if stack[0..group_end].rindex('+-')
              temp_end = stack[0..group_end].rindex('+-') #+1
              group = stack[0..temp_end]
              stack = flip_substack(stack[0..temp_end]) + stack[temp_end+1..-1]
            else
              # This shouldn't happen? But what if it does? :/ hmmmm
              puts '===== BREAK; Will this ever happen? ====='
              break;
            end
          end
        end
        # Update count
        steps += 1
      end while stack.include?('-') # keep going while un-happy pancakes exist
    end

    # Return steps
    return {steps: steps, stack: stack}
  end

  # Flip group of cakes (in stack), reversing each cake position
  def flip_substack(stack)
    # Flip each cake position && revers each cake value (happy to un-happy & vice-versa)
    flipped = "" # Will contain new "flipped" value
    # Loop the count of pancakes
    #   Idea from: https://stackoverflow.com/questions/3057967/reverse-a-string-in-ruby
    stack.length.times do |i|
      # Reverse -'s & +'s
      val = stack[-1-i] == '-' ? '+' : '-'
      flipped += val
    end
    return flipped
  end

end

# Split ARGV from first argument, and remaining arguments
tests, *stacks = ARGV
# Call logic to process each input
if fp = FlipPancakes.new({tests: tests, stacks: stacks})
  # Let's fix some pancake stacks!
  fp.process_stacks
end
