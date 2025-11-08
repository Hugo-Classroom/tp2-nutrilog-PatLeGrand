import SwiftUI

struct RootView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            HomeView()
        } else {
            LoginView(isAuthenticated: $isAuthenticated)
        }
    }
}


#Preview {
    RootView()
}
