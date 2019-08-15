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


let publisher = subject.eraseToAnyPublisher()


let subscriber1 = publisher.sink { (value) in
    print("Evento no subscriber 1: \(value)")
}

subject.send("Evento 1")
subject.send("Evento 2")
subject.send("Evento 3")

let subscriber2 = publisher.sink { (value) in
    print("Evento no subscriber 2: \(value)")
}

subject.send("Evento 4")
/*:
 Subscribers só receberam elementos depois da subscription feita.
 */
//: [Next](@next)
