@cohorts = ["january", "feburary", "march", "april", "may", "june", "july", "august", "september",
  "october", "november", "december"]
@students = [] #an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" #9 because we'll be adding more items
end

def interative_menu
  loop do 
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will cause the program to terminate
    else 
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  
  while name = STDIN.gets.chomp.capitalize do
    break if name == ""
    puts "Please enter the contry where the student is from"
    country = STDIN.gets.chomp.capitalize
    puts "Please enter the cohort which the student is in"
    cohort = STDIN.gets.chomp
    if cohort.empty? || !@cohorts.include?(cohort)
      puts "Invalid. The cohort is set to september"
      cohort = "september"
    end
    students_hash(name, country, cohort)
    if @students.count > 1
    puts "Now we have #{@students.count} students"
    else 
    puts "Now we have #{@students.count} student"
    end
  end
end

def students_hash(name, country, cohort)
  @students << {name: name, country: country, cohort: cohort.to_sym}
end

def show_students
  print_header
  print_students_list
  letters
  name_by_length
  print_by_cohort
  print_footer
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
    letter = STDIN.gets.chomp.upcase
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
    cohort = STDIN.gets.chomp.to_sym
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

#saving data from the file
def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:country], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, country, cohort = line.chomp.split(',')
    students_hash(name, country, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
  if File.exist?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else #if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

try_load_students
interative_menu
