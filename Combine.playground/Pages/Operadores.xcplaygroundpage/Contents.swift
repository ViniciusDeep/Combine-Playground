//: [Previous](@previous)
/*:
 # Operadores
 Apesar de programação reativa não ser sinônimo de reatividade, no Combine temos diversos operadores funcionais alguns muito semelhantes com os operadores nativos da própria linguagem.
 */
import Combine
import UIKit
/*:
 ## Map
 O Map do Combine é bem parecido com o Swift Map, ele serve para transforma uma sequência de valores no tipo desejado, que no nosso caso utilizaremos int
 */
_ = Publishers.Sequence(sequence: [1,2,4]).map { $0 * 10}
    .flatMap{Just($0)}
    .sink(receiveValue: {
    print("Map: \($0)")
})
/*:
 ## Filter
 O Filter serve para filtrar os valores em sequência por exemplo se um número é par, pegando o elemento e sabendo se o módulo da divisão é 0, nesse caso queremos saber os elementos da sequência
 */
_ = Publishers.Sequence(sequence: [1,2,2,3,3,4,7])
    .map { $0 * 2 }
    .flatMap { Just($0) }
    .filter { $0.isMultiple(of: 2) }
    .dropFirst(3)
    .removeDuplicates()
    .sink(receiveValue: { value in
        print("Filter: \(value)")
    })
/*:
 ## Merge
 O merge serve para você unir tipo de coleções do mesmo tipo em um só, no exemplo abaixo mergaremos de tipo String.
 */




let cearaCities = PassthroughSubject<String, Never>()
let saoPauloCities = PassthroughSubject<String, Never>()
let franceCities = PassthroughSubject<String, Never>()

let brazilCities = Publishers.Merge(saoPauloCities, cearaCities)

_ = brazilCities.sink(receiveValue: { city in
    print("\(city) is a city from Brazil")
})

cearaCities.send("Maracanaú")
franceCities.send("Paris")
saoPauloCities.send("Campinas")
cearaCities.send("Fortaleza")


/*:
 ## Schedulers
 Um dos princípais problemas da programação reativa é o back-pressure, como você tá trabalhando com dados assíncronos, muitas vezes pode acontecer que os dados veem de uma forma gigansteca e você não tenha controle sobre eles, para resolver isso pode escalar um tempo no qual o evento venha  ser executado, como o exemplo abaixo mostra
 */

let selectedFilter = PassthroughSubject<String, Never>()

let searchTextField: UITextField = {
    let tf = UITextField()
    return tf
}()

let searchText = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: searchTextField).map({ ($0.object as! UITextField).text  })
    .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
    .eraseToAnyPublisher()
//: [Next](@next)
