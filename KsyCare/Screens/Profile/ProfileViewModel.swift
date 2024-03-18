import Foundation

class ProfileViewModel: ObservableObject {
    @Published var userProfile = UserProfileModel(name: "проверка пустоты", surname: "ProfileViewModel", avatar: nil, email: "", birthDate: Date(), gender: "", weight: 0.0, height: 0.0, diabetesType: "")

    func updateProfile(with profile: UserProfileModel) {
        self.userProfile = profile
    }
}
