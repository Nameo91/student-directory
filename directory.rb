def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return instead of name"
  #create an empty array
  students = []
  cohorts = ["january", "feburary", "march", "april", "may", "june", "july", "august", "september",
  "october", "november", "december"]
  name = gets.chomp
  #while the name is entered, repeat this code
  while !name.empty? do
    puts "Please enter the contry where the student is from"
    country = gets.chomp.capitalize
    puts "Please enter the cohort which the student is in"
    cohort = gets.chomp
    if cohort.empty? || !cohorts.include?(cohort)
      puts "Invalid. The cohort is set to september"
      cohort = "september"
    end
    
    students << {name: name, country: country.to_sym, cohort: cohort}
    puts "Now we have #{students.count} students"
    
    puts "Please enter the name of the student"
    name = gets.chomp
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "------------".center(32)                  
end

def print(students)
  i = 0
  while i < students.count
    #set count as index of students array
    puts "#{i+1}. #{students[i][:name]} from #{students[i][:country]} (#{students[i][:cohort]} cohort)"
    i += 1
  end
end

def letters(students)
  #get the lette which the students name begins with
  puts "Please enter the first letter of name you want to find"
  letter = gets.chomp.upcase
  students.each do |student| 
    #only print out if the name begins with the letter
    if student[:name].start_with?(letter)
      puts "#{student[:name]} from #{students[:country]} (#{student[:cohort]} cohort)"
    end
  end
end

def name_by_length(students)
  puts "The students whose name is shorter than 12: "
  students.each do |student|
    if student[:name].gsub(/\s+/,"").length < 12
      puts "#{student[:name]} from #{students[:country]} (#{student[:cohort]} cohort)"
    end
  end
end


def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(38)
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)