import SwiftUI

struct SettingsView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State private var notificationsEnabled = false
    @State private var selectedThemeIndex = 0
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    @State private var showSignIn = false
    @Environment(\.dismiss) private var dismiss
    private let themes = ["Light", "Dark", "System"]
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("Appearance")) {
                        Toggle("Dark Mode", isOn: $darkModeEnabled)
                    }
                    
                    Section(header: Text("Notifications")) {
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    }
                    
                    Section(header: Text("Account")) {
                        Button(action: {
                            // Action for signing out
                            showingActionSheet = true
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.red)
                                .font(.body)
                        }
                        .actionSheet(isPresented: $showingActionSheet) {
                            ActionSheet(title: Text("Are you sure you want to sign out?"), buttons: [
                                .destructive(Text("Sign Out")) {
                                    // Perform sign out action
                                    showingAlert = true
                                    FirebaseManager.shared.signOut()
                                },
                                .cancel()
                            ])
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Signed Out"),
                                message: Text("You have been signed out successfully."),
                                dismissButton: .default(Text("OK")) {
                                    // Action to perform when OK is tapped
                                    showSignIn = true
                                }
                            )
                        }
                        .fullScreenCover(isPresented: $showSignIn) {
                            SignView()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.light)
    }
}
