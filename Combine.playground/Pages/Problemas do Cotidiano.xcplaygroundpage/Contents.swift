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



let baseUrl = "https://jsonplaceholder.typicode.com/posts"


struct Post: Decodable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

URLSession.shared.dataTaskPublisher(for: URL(string: baseUrl)!).map{$0.data}.decode(type: [Post].self, decoder: JSONDecoder()).map({post in
    print(post)
})


class Service {
    class func getAllPosts(completion: @escaping ([Post]) -> ()) {
        
        guard let url = URL(string: baseUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async {
                completion(posts)
            }
        }.resume()
        
    }
}

let posts = Service.getAllPosts { (posts) in
    print(posts)
}

/*:
 Tratamento de erro com Enum, vimos que publisher pode retornar erros que podem ser tratados com operadores funcionais como o flatMap por exemplo, porém podemos tratá-los com enums
 */


enum Error: Swift.Error {
    case somethingWentWrong
}

let subject = PassthroughSubject<Void, Error>()

subject.sink(receiveCompletion: { _ in
    print("Completado")
}) { (value) in
    print(value)
}

//: [Next](@next)

