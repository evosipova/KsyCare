import Foundation

class NetworkService {
    static let shared = NetworkService(); private init() { }
    private let localhost = "http://127.0.0.1:8080"

    func auth(login: String, password: String) async throws -> User {
        let dto = UserDTO(login: login, password: password)

        guard let url = URL(string: "\(localhost) \(APIMethod.auth.rawValue)") else {
            throw NetworkError.badURL
        }

        var request = URLRequest (url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder ()
        let data = try encoder.encode (dto)
        request.httpBody = data
        let userResponce = try await URLSession.shared.data(for: request)
        let userData = userResponce.0
        let decoder = JSONDecoder ()
        let user = try decoder.decode(User.self, from: userData)
        return user

    }
}
struct UserDTO:Codable {
    let login: String
    let password: String

}


enum APIMethod: String {
    case auth = "/users/auth"
}

enum NetworkError: Error {
    case badURL
}
