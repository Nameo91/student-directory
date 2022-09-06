def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp.capitalize
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    #get another name from the user
    name = gets.chomp.capitalize
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  counter = 0
  while counter < students.count
    #set count as index of students array
    puts "#{counter+1}. #{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
    counter += 1
  end
end

def letters(students)
  #get the lette which the students name begins with
  puts "Please enter the first letter of name you want to find"
  letter = gets.chomp.upcase
  students.each do |student| 
    #only print out if the name begins with the letter
    if student[:name].start_with?(letter)
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def name_by_length(students)
  puts "The students whose name is shorter than 12: "
  students.each do |student|
    if student[:name].gsub(/\s+/,"").length < 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end


def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)