import SwiftUI
import Combine


struct ParsedItem: Decodable {
    let food: FoodItem
}

struct Hint: Decodable {
    let food: FoodItem
}

struct ApiResponse: Decodable {
    let text: String
    let parsed: [ParsedItem]
    let hints: [Hint]
}

struct FoodItem: Identifiable, Decodable {
    var id: String { label }
    let label: String
    let nutrients: Nutrients
    let image: URL?
    let sugar: Double?

    enum CodingKeys: String, CodingKey {
        case label
        case nutrients
        case image
        case sugar = "SUGAR"
    }
}

struct FoodRowView: View {
    let item: FoodItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.label)
                .font(.headline)
            if let imageUrl = item.image {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            }
            if let calories = item.nutrients.ENERC_KCAL {
                Text("Calories: \(calories)")
            }
            if let protein = item.nutrients.PROCNT {
                Text("Protein: \(protein)g")
            }
            if let fat = item.nutrients.FAT {
                Text("Fat: \(fat)g")
            }
            if let carbs = item.nutrients.CHOCDF {
                Text("Carbs: \(carbs)g")
            }
            if let sugar = item.sugar {
                Text("Sugar: \(sugar)g")
            }
        }
    }
}


struct Nutrients: Decodable {
    let ENERC_KCAL: Double?
    let PROCNT: Double?
    let FAT: Double?
    let CHOCDF: Double?
    let FIBTG: Double?    
}

class FoodSearchViewModel: ObservableObject {
    @Published var foodItems: [FoodItem] = []
    @Published var searchText = ""

    private var cancellables = Set<AnyCancellable>()
    private let appId = "60411ffd"
    private let appKey = "e6821323d9e65625f4f9d17f0487ec5b"
    private let apiUrl = "https://api.edamam.com/api/food-database/v2/parser"

    init() {
        $searchText
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { [unowned self] query -> AnyPublisher<[FoodItem], Never> in
                self.search(query: query)
            }
            .assign(to: \.foodItems, on: self)
            .store(in: &cancellables)
    }

    func search(query: String) -> AnyPublisher<[FoodItem], Never> {
        guard !query.isEmpty,
              let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(apiUrl)?app_id=\(appId)&app_key=\(appKey)&ingr=\(encodedQuery)") else {
            return Just([]).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ApiResponse.self, decoder: JSONDecoder())
            .map { response in
                return response.hints.map { $0.food }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}

struct ContentView: View {
    @StateObject var viewModel = FoodSearchViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.foodItems) { item in
                FoodRowView(item: item)
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Search Foods")
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
