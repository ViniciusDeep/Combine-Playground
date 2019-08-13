//: [Previous](@previous)
/*:
 # Problemas do Cotidiano
 O Combine resolve vários problemas do cotidiano com o próprio back-pressure com o uso do debounce citado anteriormente, porém
 
 */
import Combine
import Foundation

/*:
 Lidar com Oberserver do Notification Center pode ser tornar declarativo utilizando o Combine
 */
/*:
# Consumo de API
Com leves alterações que aconteceram no Foundation agora conseguimos escrever um Data Task com um publisher que emitirá os valores que serão publicados, e podendo assim receber esses valores de data com um subscriber
*/

struct Repositorie: Decodable {
    let url: URL?
    let countContribution: Int?
}

let url = "www.github.api"

URLSession.shared.dataTaskPublisher(for: URL(string: url)!).map { $0.data }.decode(type: Repositorie.self, decoder: JSONDecoder())





//: [Next](@next)

