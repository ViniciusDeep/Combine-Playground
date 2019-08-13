//: [Previous](@previous)

import Combine
import Foundation

/*:
 # Subjects
 
 Um subject é um publisher que expoe um método para publishers externo publicarem elementos
 
 */

let subject = PassthroughSubject<String, Never>()

subject.sink { (value) in
    print(value)
}

subject.send("Vinicius")
subject.send("Maria")
subject.send("Yuri")




//: [Next](@next)
