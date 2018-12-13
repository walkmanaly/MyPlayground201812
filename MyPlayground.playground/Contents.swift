//: Playground - noun: a place where people can play

import UIKit

let names = ["allan", "bob", "cat", "dog", "eason"]

func reverst(_ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}
let reversName = names.sorted(by: reverst)

// closure style 1  完全的写法
let reverse1 = names.sorted(by:{(s1: String, s2: String) -> Bool in
    return s1 > s2
})

// closure style 2  类型推导，不用指明s1， s2类型 以及返回值类型
let reverse2 = names.sorted(by: {s1, s2 in return s1 > s2})

// closure style 3  可以省略return关键字
let reverse3 = names.sorted(by: {s1, s2 in s1 > s2})

// closure style 4  可以使用默认参数
let reverse4 = names.sorted(by: {$0 > $1})

// closure style 5  可以使用运算符
let reverse5 = names.sorted(by: >)

// 尾随闭包
// traillingClosure style 1
let reverse6 = names.sorted() {$0 > $1}

func traillingClosure(closure: () -> Void) {
    // function gos here
}
// 调用传入closure参数的方法
traillingClosure(closure: {
    // closure body gos here
})

// 用尾随闭包方式来调用传入closure参数的方法
traillingClosure() {
    // closure body gos here
}

// traillingClosure style 2
let reverse7 = names.sorted {$0 > $1}

// 尾随闭包的好处
let digitName = [0: "zero", 1: "one", 2: "two", 3: "three", 4: "foure", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine"]
let digits = [63, 20, 309]

let transDigits = digits.map {(number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitName[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// 尾随闭包只是写法上的一种方式不一样而已
let transDigitClosure = digits.map({(number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitName[number % 10]! + output
        number /= 10
    } while number > 0
    return output
})

// closure 捕获作用域的变量
func incrementInt(amount: Int) -> () -> Int {
    var total = 0

    func increment() -> Int {
        total += amount
        return total
    }

    return increment
}


let incrementTen = incrementInt(amount: 10)

print(incrementTen())
print(incrementTen())

let incrementEight = incrementInt(amount: 8)
print(incrementEight())
print(incrementEight())

print(incrementTen())


// escaping
typealias someClosureType = () -> Void
var closureArray: [someClosureType] = []

func someEscapingClosure(completionHandle: @escaping someClosureType) {
    closureArray.append(completionHandle)
}

func someNonEscapingClosure(closure: someClosureType) {
    closure()
}

class SomeClass {
    var x = 0
    func doSomething() {
        someEscapingClosure {
            self.x = 200
        }
        someNonEscapingClosure {
            x = 100
        }
    }
}

let instance = SomeClass()

instance.doSomething()
print(instance.x)

closureArray.first?()
print(instance.x)


// 自动闭包
var someNames = ["Nick", "Rose", "Bob", "Jack"];
let autoClosure = {
    someNames.remove(at: 0)
}

print(autoClosure())
//print(autoClosure())

var autoClosures: [() -> String] = []

func addAutoClosures(_ autoClosure:@autoclosure @escaping () -> String) {
    autoClosures.append(autoClosure)
}

addAutoClosures(someNames.remove(at: 0))

for closure in autoClosures {
    print("----\(closure())")
}


//-----------------------------------enum--------------------------------
// 一：书写形式
// 形式1
enum Derection {
    case east
    case south
    case west
    case north
}

// 形式2
enum Color {
    case red, blue, green, black, white
}
// 二：使用
var firstDerection = Derection.west
// 1、类型推导,以.开头简写
firstDerection = .north
print(firstDerection)
// 2.1、没有default分支，必须要穷举所有的case，否则编译报错
switch firstDerection {
case .east:
    print("east")
case .west:
    print("west")
case .north:
    print("north")
case .south:
    print("south")
}
// 2.2、使用default分支忽略其他case
switch firstDerection {
case .east:
    print("derection is east")
default:
    print("other decretion")
}
// 3.1、遍历枚举的所有case,需要遵循CaseIterable协议
enum weekdays: CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}
// 遍历
for weekday in weekdays.allCases {
    print(weekday)
}
// 3.2、case总数
let weekdayNums = weekdays.allCases.count
print("weekdayNums = \(weekdayNums) days")
// 4、关联值
enum ProductCode {
    case cup(Int, Int, Int, Int)
    case qr(String)
}

var products = ProductCode.cup(12, 453, 8689, 2)
print(products)
products = .qr("JGUYFHJGG")
print(products)
// 4.1、在匹配的case可以取到相应的关联值
switch products {
case .cup(let numberOne, let numberTwo, let numberThree, let numberFour):
    print("numbers = \(numberOne),\(numberTwo),\(numberThree),\(numberFour)")
case .qr(let qrStr):
    print("qrcode = \(qrStr)")
}
// 4.2、4.1的另一种写法
switch products {
case let .cup(numberOne, numberTwo, numberThree, numberFour):
    print("numbers = \(numberOne),\(numberTwo),\(numberThree),\(numberFour)")
case let .qr(qrStr):
    print("qrcode = \(qrStr)")
}
// 5.1、默认值raw value-------“When strings are used for raw values, the implicit value for each case is the text of that case’s name”
enum Lesson: String {
    case Chinese //= "Chinese lesson"
    case English //= "English lesson"
    case Math //= "Math lesson"
}

let lessonOne = Lesson.English
print(lessonOne)
print(lessonOne.rawValue)
// 5.2 “If the first case doesn’t have a value set, its value is 0”
enum Score: Int {
    case excellent
    case good
    case certified
    case faliure
}
let mathScore = Score.excellent
print(mathScore)
print(mathScore.rawValue)
// 6、初始化携带默认值时
var oneScoreRawValue = 2
var oneScore = Score(rawValue: oneScoreRawValue)
if let oneScore = oneScore {
    switch oneScore {
    case .excellent:
        print("your score is excellent!")
    default:
        print("just so so")
    }
} else {
    print("score does not exit!")
}
// 7、递归枚举
// TODO

//--------------------------struct------------------


//--------------------------class---------------------
// type casting  类型判断：判断某个实例是否属于某个类 is as as? as!
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var derector: String
    init(name: String, derector: String) {
        self.derector = derector
        super.init(name: name)
    }
}

class Music: MediaItem {
    var song: String
    init(name: String, song: String) {
        self.song = song
        super.init(name: name)
    }
}

let medias = [
    Movie(name: "Iron Man", derector: "tony"),
    Music(name: "rose", song: "westlife"),
    Movie(name: "Bat man", derector: "nuolan"),
    Music(name: "beat it", song: "mical jason"),
    Movie(name: "super man", derector: "jack")
]

var moviesNum = 0
var musicNum = 0
for item in medias {
    if item is Movie {
        moviesNum += 1
    } else {
        musicNum += 1
    }
}
print("movie has \(moviesNum), music has \(musicNum)")

for item in medias {
    if let movie = item as? Movie {
        print("movie name is \(movie.name), decector is \(movie.derector)")
    } else if let music = item as? Music {
        print("music name \(music.name), song \(music.song)")
    }
}

// 定义一个struct,每当你定义一个struct或class，你就创建了一个新的swift类型
struct SomeStruct {

}

let oneStruct = SomeStruct()















