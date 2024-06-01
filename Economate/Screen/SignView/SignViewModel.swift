import Foundation

class SignViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var emailF = ""
    @Published var nameF = ""
    @Published var passwordF = ""
    @Published var showAlert = false
    @Published var isLoggedIn = false
    @Published var isSignedUp = false
    @Published var showWrongAlert = false
    @Published var isLoading: Bool = false
    
    
    
    func loginTapped(){
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.isEmpty {
            showAlert = true
            print("Email or password is empty")
            return
        }
        
        isLoading = true
        
        
        Task{
            do{
                try await FirebaseManager.shared.signIn(withEmail: email, password: password)
                DispatchQueue.main.async {
                    //                        self.errorMessage = FirebaseManager.shared.errorMessage?.localizedDescription ?? ""
                    //                        self.showWrongAlert = FirebaseManager.shared.showErrorAlert
                    self.isLoading = false
                    self.isLoggedIn = FirebaseManager.shared.isLoggedIn
                    
                    if(!self.isLoggedIn){
                        self.showWrongAlert = true;
                    }
                    //Navigate to Home Page
                }
            }
            catch{
                print("Error occurs at sign in")
            }
        }
    
    }
    
    func signUpTapped() {
        if emailF.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || passwordF.isEmpty {
            showAlert = true
            print("Email, username or password is empty")
            return
        }
        
        Task {
            do {
                try await FirebaseManager.shared.signUp(withEmail: emailF, password: passwordF)
                DispatchQueue.main.async {
                    self.isSignedUp = FirebaseManager.shared.isSignedUp
                    if !self.isSignedUp {
                                           self.showWrongAlert = true
                                           print("Error occurs at sign up1")
                                       }
                }
            } catch {
                print("Error occurs at sign up2")
            }
        }
    }
}

