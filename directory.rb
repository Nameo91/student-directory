require 'csv'
@cohorts = ["january", "feburary", "march", "april", "may", "june", "july", "august", "september",
  "october", "november", "december"]
@students = [] #an empty array accessible to all methods
@default_file = "students.csv"

def print_main
  puts "Main Menu"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Search the students"
  puts "4. Save the list to file"
  puts "5. Load the list from file"
  puts "9. Exit" 
end

def interative_main
  loop do 
    print_main
    process_main(STDIN.gets.chomp)
  end
end

def process_main(selection)
  case selection
    when "1"
      input_students
      total_students_number
    when "2"
      show_students
    when "3"
      interative_search
    when "4"
      puts "Please enter the name of file to save(eg. students.csv)"
      saved_file = gets.chomp
      saved_file.empty? ? save_students : save_students(saved_file)
    when "5"
      puts "Please enter the name of file to load(eg. students.csv)"
      loaded_file = gets.chomp
      loaded_file.empty? ? load_students : load_students(loaded_file)
    when "9"
      exit # this will cause the program to terminate
    else 
      puts "I don't know what you meant, try again"
  end
end

def print_search
  puts "Students Search"
  puts "1. Search by First letter"
  puts "2. Search by Name less than 12 characters"
  puts "3. Search by cohort"
  puts "4. Back to Main Menu"
end

def interative_search
  loop do 
    print_search
    process_search(STDIN.gets.chomp)
  end
end

def process_search(selection)
  case selection
    when "1"
      letters
    when "2"
      name_by_length
    when "3"
      print_by_cohort
    when "4"
      interative_main
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
    add_students(name, country, cohort)
  end
end

def total_students_number
    if @students.count > 1
    puts "Now we have #{@students.count} students"
    else 
    puts "Now we have #{@students.count} student"
    end
end

def add_students(name, country, cohort)
  @students << {name: name, country: country, cohort: cohort.to_sym}
end

def show_students
  print_header
  print_students_list
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
def save_students(filename = @default_file)
  #open the CSV file for writing
  CSV.open(filename, "wb") do |csv|
  #iterate over the array of students
    @students.each do |student|
      csv << [student[:name], student[:country], student[:cohort]]
    end
    puts "------------".center(23)
    puts "Saved successfully to #{filename}"
    puts "------------".center(23)
  end
end

def load_students(filename = @default_file)
  if File.exist?(filename)
  CSV.foreach(filename, "r") do |row|
    name, country, cohort = row
    add_students(name, country, cohort)
  end
  puts "-------------".center(36)
  puts "#{filename} loaded successfully"
  puts "-------------".center(36)
  end
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  if filename.nil? #students.csv is a default if it isn't given
    puts "Default file: #{@default_file} file is loaded"
    load_students
    return
  end
  if File.exist?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else #if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

try_load_students
interative_main
