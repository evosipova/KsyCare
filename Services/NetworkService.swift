import Foundation

class NetworkService {
    static let shared = NetworkService(); private init() { }
    private let localhost = "http://89.175.18.189:8080"

    func auth(login: String, password: String) async throws -> User {
        let dto = UserDTO(login: login, password: password)

        guard let url = URL(string: "\(localhost)\(APIMethod.auth.rawValue)") else {
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

    func register(name: String, login: String, password: String, role: String) async throws -> User {
        let dto = CreateUserDTO(name: name, login: login, password: password, role: role)

        guard let url = URL(string: "\(localhost)\(APIMethod.register.rawValue)") else {
            throw NetworkError.badURL
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try encoder.encode(dto)
        request.httpBody = data
        let userResponse = try await URLSession.shared.data(for: request)
        let userData = userResponse.0
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: userData)
        return user
    }
}
struct UserDTO:Codable {
    let login: String
    let password: String

}

struct CreateUserDTO: Codable {
    let name: String
    let login: String
    let password: String
    let role: String
}



enum APIMethod: String {
    case auth = "/users/auth"
    case register = "/users"
}

enum NetworkError: Error {
    case badURL
}
