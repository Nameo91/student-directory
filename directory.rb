@cohorts = ["january", "feburary", "march", "april", "may", "june", "july", "august", "september",
  "october", "november", "december"]
@students = [] #an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return instead of name"
  while name = gets.strip.capitalize do
    break if name == ""
    puts "Please enter the contry where the student is from"
    country = gets.chomp.capitalize
    puts "Please enter the cohort which the student is in"
    cohort = gets.chomp
    if cohort.empty? || !@cohorts.include?(cohort)
      puts "Invalid. The cohort is set to september"
      cohort = "september"
    end
    
    @students << {name: name, country: country.to_sym, cohort: cohort}
    if @students.count > 1
    puts "Now we have #{@students.count} students"
    else 
    puts "Now we have #{@students.count} student"
    end
  end
end

def interative_menu
  loop do 
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Show the students by the first letter of thier name"
  puts "4. Show the students whose name is shorter than 12 characters"
  puts "5. Show the students in the same cohort"
  puts "9. Exit" #9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      letters
    when "4"
      name_by_length
    when "5"
      print_by_cohort
    when "9"
      exit # this will cause the program to terminate
    else 
      puts "I don't know what you meant, try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "------------".center(32)  
end

def print_students_list
  unless @students.count < 1  
    @students.each_with_index do |student, i|
      puts "#{i+1}. #{student[:name]} from #{student[:country]} (#{student[:cohort]} cohort)"
    end
  end
end

def letters
  unless @students.size < 1
    puts "Please enter the first letter of name you want to find"
    letter = gets.chomp.upcase
    @students.each do |student| 
      if student[:name].start_with?(letter)
        puts "#{student[:name]} from #{student[:country]} (#{student[:cohort]} cohort)"
      end
    end 
  end
end

def name_by_length
  unless @students.size < 1
    puts "The students whose name is shorter than 12 characters: "
    @students.each do |student|
      if student[:name].gsub(/\s+/,"").length < 12
        puts "#{student[:name]} from #{student[:country]} (#{student[:cohort]} cohort)"
      end
    end
  end
end

def print_by_cohort
  unless @students.size < 1
  puts "Which cohort you want to meet"
    cohort = gets.chomp
    @students.map do |student|
      if student[:cohort] == cohort
        puts student[:name]
      end
    end
  end
end
    
def print_footer
  if @students.count > 1 
  puts "Overall, we have #{@students.count} great students".center(38)
  elsif @students.count == 1
  puts "Overall, we have #{@students.count} great student".center(38)
  end
end

interative_menu
