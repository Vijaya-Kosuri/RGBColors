
//a. In the assignment for Week 3, part D asked you to write a function that would compute the average of an array of Int. Using that function and the array created in part A, create two overloaded functions of the function average.


let nums = Array(0...20)

func calculateAverage(_ values: [Int]) -> Double?
{
  guard !values.isEmpty else {
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

func calculateAverage(_ values: [Int]?)
{

  if let numbers = values {
    let avg = calculateAverage(numbers)
  }
  else {
    print("The average is NIL")
  }
}

calculateAverage(nums)
calculateAverage(nil)


//b. Create an enum called Animal that has at least five animals. Next, make a function called theSoundMadeBy that has a parameter of type Animal. This function should output the sound that the animal makes.

enum Animal {
  case cat, dog, cow, snake, pig
}


func theSoundMadeBy(for Animals: [Animal]) {
  for pet in Animals {
    switch pet {
    case .cat :
      print ("The \(pet) says Meow")
    case .dog :
      print ("The \(pet) says bow bow")
    case .cow :
      print ("The \(pet) says moo")
    case .snake :
      print ("The \(pet) says hiss")
    case .pig :
      print ("The \(pet) says oink")
    
    }
  }
}

theSoundMadeBy(for: [.cat])
theSoundMadeBy(for: [.snake])


//c. Create an array of Int called numsBy2 with values starting at 2 through 100, by 2.
//Create an array of Int called numsBy4 with values starting at 2 through 100, by 4.


let numbers = Array(0...100)
let numsWithNil : [Int?] = [79, nil, 80, nil, 90, nil, 100, 72]

//option1 in one statement
let numsBy2 = Array(stride(from: 2, through: 100, by: 2))

//option2 in multiple statements
//var numsBy2 = numbers.filter {
//  $0 > 1 && $0 % 2 == 0
//}.map {
//  $0 * 2
//}
print(numsBy2)

//option1 in one sentence
let numsBy4 = Array(stride(from: 2, through: 100, by: 4))

//option2 in multiple statements
//var numsBy4 = numbers.filter {
//  $0 > 1 && $0 % 2 == 0
//}.map {
//  $0 * 4
//}

print(numsBy4)
//Create a function called evenNumbersArray that takes a parameter of [Int] (array of Int) and returns [Int]. The array of Int returned should contain all the even numbers in the array passed. Call the function passing the nums array and print the output.


func evenNumbersArray(_ nums: [Int] ) -> [Int] {
  let returnEven = nums.filter {
    $0 % 2 == 0
  }
  return returnEven
}
  
evenNumbersArray(numbers)

//Create a function called sumOfArray that takes a parameter of [Int?] and returns an Int. The function should return the sum of the array values passed that are not nil. Call the function passing the numsWithNil array, and print out the results.

func sumOfArray(_ nums: [Int?] ) -> Int? {
  guard !nums.isEmpty else {
    print("The array is nil. Calculating the sum is impossible.")
    return nil
    }
  let nonnil = nums.compactMap{ $0 }
  return nonnil.reduce(0, +)
}
sumOfArray(numsWithNil)


//Create a function called commonElementsSet that takes two parameters of [Int] and returns a Set<Int> (set of Int). The function will return a Set<Int> of the values in both arrays.
func commonElementsSet(_ nums1 : [Int], _ nums2 : [Int]) -> Set<Int>
{
  let set1 = Set(nums1)
  let set2 = Set(nums2)
  
  return set1.intersection(set2)
}

commonElementsSet(numsBy2, numsBy4)


//Create a struct called Square that has a stored property called sideLength and a computed property called area. Create an instance of Square and print the area.

struct Square {
  var sideLength : Int
  var area : Double {
    get { return Double((sideLength * sideLength)) }
  }
}

var completeArea = Square(sideLength : 5)
completeArea.area


//Part 3 - Above and Beyond

protocol Shape {
  var calculateArea : Double { get }
  var calculateVolume : Double { get }
  
}

struct Circle : Shape {
  let radius : Double
  
  var calculateArea : Double {
    .pi * radius * radius
  }
  
  //Circle doesnt have volume. Its the same as area
  var calculateVolume : Double {
    .pi * radius * radius
  }
  
}

struct Rectangle : Shape {
  let length : Double
  let breadth : Double
  let height : Double
  
  var calculateArea : Double {
    length * breadth
  }
  
  var calculateVolume : Double {
    length * breadth * height
  }
}

struct Sphere : Shape {
  let radius : Double
  
  var calculateArea : Double {
    .pi * radius * radius
  }
  var calculateVolume : Double {
    .pi * 1.3 * radius * radius * radius
  }
}

let circle = Circle(radius: 5)
let rectangle = Rectangle(length: 5, breadth: 8, height: 4)
let sphere = Sphere(radius: 6)
let shapes: [Shape] = [circle, rectangle, sphere]

print(shapes.map{ $0.calculateArea})
print(shapes.map { $0.calculateVolume})





