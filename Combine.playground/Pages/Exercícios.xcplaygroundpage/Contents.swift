//: [Previous](@previous)

import Combine

/*:
 ## Problema simples da temperatura
      Imagine que queremos publicar eventos sobre a temperatura e queremos, saber quando a temperatura estiver acima de 25 graus, para que possamos mostrar pro usuário algum tipo de resposta
 */

let publisher = PassthroughSubject<Int, Never>()

let subscriber = publisher.filter{$0 > 25}.sink { (value) in
    print("A tempetura ambiente é de: \(value), está quente")
}

let anotherSubscriber = publisher.handleEvents(receiveSubscription: {subscription in
    print("New Subscription \(subscription)")
}, receiveOutput: {output in
    print("New Output \(output)")
}, receiveCompletion: {error in
    print("Subscriber pode ter um erro em \(error)")
}, receiveCancel: {
    print("Subscription cancelled")
}, receiveRequest: {receive in
    print("Requisão de resposta \(receive)")
    }).sink(receiveValue: {value in
        print(value)
    })


publisher.send(28)
publisher.send(10)
publisher.send(30)
publisher.send(25)
publisher.send(12)
publisher.send(40)
publisher.send(72)

//: [Next](@next)
