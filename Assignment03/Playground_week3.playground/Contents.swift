import Cocoa

//Create an array of Int called nums with values 0 through 20. Iterate over the Array and print the even numbers.

let nums = Array(0...20)

print ("Even numbers:")
for numbers in nums {
  if numbers%2 == 0 {
    print(numbers)
  }
}


//Iterate over sentence counting the vowels (a, e, i, o, u), ignoring the case.

let sentence = "The qUIck bRown fOx jumpEd over the lAzy doG"
let vowels : [Character] = ["a","e","i","o","u"]
var count = 0
for charecter in sentence.lowercased(){
  if (vowels.contains(charecter)) {
    count += 1
  }
}
print(count)


//Create two arrays of Int with the values of 0 through 4. Use a nested for loop to print a mini multiplication table. The output, which should be multiple lines, should be in the following format:
//0 * 0 = 0

let multi1 = Array(0...4)
let multi2 = Array(0...4)

for i in multi1 {
  for j in multi2 {
    
    print ("\(i) * \(j) = \(i*j)")
  }
}


//Write a function called average that takes an optional array of Int. If the array is not nil, calculate the average of the array's values and print:

func calculateAverage(values: [Int]?) -> Double?
{
  guard let values = values, !values.isEmpty else {
    print("The array is nil. Calculating the average is impossible.")
              return nil
          }
    var sum = 0
    for k in values {
      sum += k
  }
  let average = Double(sum)/Double(values.count)
  print("The average of the values in the array is : \(average)")
  return average
}

calculateAverage(values:nums)
calculateAverage(values: nil)


//Create a struct called Person with the properties firstName, lastName, and age. Choose appropriate data types for the properties. Include a method on Person called details that prints the values stored in the properties in the following format:

struct Person {
  
  let firstName : String
  let lastName : String
  let age : Int
  
  func details()
  {
    print("\(firstName) \(lastName), Age: \(age)")
  }
}

let person = Person(firstName:"Vijaya",lastName:"Kosuri",age:35)

person.details()


//Create a class called Student with two properties: person of type Person and grades, an array of Int. The class must have a method called calculateAverageGrade that takes no parameters and returns a Double. Include a method called details that prints the values of the properties stored in Student along with the average grade in the following format:

class Student {
  let person : Person
  let grades : [Int]
  
  init(person: Person, grades: [Int])
  {
    self.person = person
    self.grades = grades
  }
  
  func calculateAverageGrade() -> Double
  {
    var sum = 0
    for k in grades {
      sum += k
    }
  let average = Double(sum)/Double(grades.count)
  return average
  }
  
  func details(){
    
    let cgpa = calculateAverageGrade()
    print("Name: \(person.firstName) \(person.lastName), Age: \(person.age), GPA: \(cgpa)")
    
  }
  
}

let stud = Student(person: Person(firstName: "Vijaya", lastName: "Kosuri", age: 35),grades:[94,99,81,100,79])
stud.details()



// Above and Beyond

struct Square {
  var side: Int
  func area() -> Int {
    return side * side
  }
}

class Rectangle {
  var length: Int
  var width: Int
  init(length: Int, width: Int) {
    self.length = length
    self.width = width
  }
  func area() -> Int {
    return length * width
  }
}

var square1 = Square(side: 4)
var square2 = square1
square2.side = 5
print("Area: square1 - \(square1.area()) square2 - \(square2.area())")

var rectangle1 = Rectangle(length: 4, width: 4)
var rectangle2 = rectangle1
rectangle2.length = 5
print("Area: rectangle1 - \(rectangle1.area()) rectangle2 - \(rectangle2.area())")
