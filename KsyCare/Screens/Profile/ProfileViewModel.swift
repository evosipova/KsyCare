import Foundation

class ProfileViewModel: ObservableObject {
    @Published var userProfile = UserProfileModel(avatar: nil, email: "", birthDate: Date(), gender: "", weight: 0.0, height: 0.0, diabetesType: "", bloodSugarNorm: "")

    func updateProfile(with profile: UserProfileModel) {
        self.userProfile = profile
    }
}
