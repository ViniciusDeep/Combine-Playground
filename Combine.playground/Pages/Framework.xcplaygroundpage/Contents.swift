//: [Previous](@previous)
/*:
 # Framework
  Varios conceitos do framework são bem interessantes, o primeiro que vamos ver são sobre os Publishers e Subscribers
*/
/*:
 ## Publisher
 
 É um protocolo no qual quem assina pode entrar uma sequência de valores ao longo tempo,  quando você implementa esse protocolo, ele pede que você diga qual o tipo de saída você deseja que alguém retorne, e a possibilidade de erro.
 
 */
import Combine
import UIKit

class MyPublisher: Publisher {
    typealias Output = String
    typealias Failure = Error //Você pode também pode declarar Never se não existir nenhum erro

    // Essa função é chamada para anexar um Subscriber para esse Publisher
    func receive<S>(subscriber: S) where S : Subscriber, MyPublisher.Failure == S.Failure, MyPublisher.Output == S.Input {
           print("Register Subscriber")
       }
}
/*:
 ## Subscribers
 Um subscriber irá agir sobre um evento, os publishers somente emitiram valores quando forem explicitamente solicitados pelo seu subscriber
*/

var publisher = Just(19)

publisher.map { (number)  in
    return "Vinicius tem \(number) anos"
}.sink { (value) in
    print(value)
}

/*:
 Nós também podemos fazer um sink somente quando a propagação for finalizada
 */

publisher.sink(receiveCompletion: { _ in
    print("Evento finalizado")
}) { value in
    print(value)
}

/*:
 # Personalizando nosso próprio Publisher
 */
/*:
 Para começar criaremos nossa própria Subscription
 */

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    
    var subscriber: SubscriberType?
    
    private let control: Control
    
    init(subscriber: SubscriberType, control: Control, event: UIControl.Event){
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() {
        subscriber = nil
    }
    
    @objc func eventHandler() {
        _ = subscriber?.receive(control)
    }
    
}

class UIControlPublisher<Control: UIControl>: Publisher {
    typealias Output = Control
    
    typealias Failure = Never
    
    let control: Control
    let controlEvents: UIControl.Event
    
    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, UIControlPublisher.Failure == S.Failure, UIControlPublisher.Output == S.Input {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents)
        subscriber.receive(subscription: subscription)
    }
}

/*:
 ## Publisher + Subscriber
 
 ### Publisher
 * Define com valores e erros são produzidos
 * Value Type
 * Permite os registros pelos subscribers
 
 ### Subscriber
  * Recebe os valores
  * Reference Type
  * Recebe os valores e pode reagir com uma ação
 */

//: [Next](@next)
