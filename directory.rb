@cohorts = ["january", "feburary", "march", "april", "may", "june", "july", "august", "september",
  "october", "november", "december"]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return instead of name"
  #create an empty array
  students = []
  #while the name is entered, repeat this code
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
    
    students << {name: name, country: country.to_sym, cohort: cohort}
    if students.count > 1
    puts "Now we have #{students.count} students"
    else 
    puts "Now we have #{students.count} student"
    end
    puts "Please enter the name of the student"
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "------------".center(32)  
end

def print(students)
  if students.size > 1  
    #set count as index of students array
    students.each_with_index do |student, i|
      puts "#{i+1}. #{students[i][:name]} from #{students[i][:country]} (#{students[i][:cohort]} cohort)"
    end
  end
end

def letters(students)
  if students.size > 1
  #get the lette which the students name begins with
    puts "Please enter the first letter of name you want to find"
    letter = gets.chomp.upcase
    students.each do |student| 
    #only print out if the name begins with the letter
      if student[:name].start_with?(letter)
        puts "#{student[:name]} from #{student[:country]} (#{student[:cohort]} cohort)"
      end
    end 
  end
end

def name_by_length(students)
  if students.size > 1
    puts "The students whose name is shorter than 12: "
    students.each do |student|
      if student[:name].gsub(/\s+/,"").length < 12
        puts "#{student[:name]} from #{student[:country]} (#{student[:cohort]} cohort)"
      end
    end
  end
end

def print_by_cohort(students)
  if students.size > 1
  puts "Which cohort you want to meet"
    cohort = gets.chomp
    students.map do |student|
      if student[:cohort] == cohort
        puts student[:name]
      end
    end
  end
end
    
def print_footer(names)
  if names.count > 1 
  puts "Overall, we have #{names.count} great students".center(38)
  elsif names.count == 1
  puts "Overall, we have #{names.count} great student".center(38)
  end
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
letters(students)
name_by_length(students)
print_by_cohort(students)
print_footer(students)