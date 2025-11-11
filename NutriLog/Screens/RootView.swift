import SwiftUI

struct RootView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        VStack(){
            if isAuthenticated {
                HomeView()
            } else {
                LoginView(isAuthenticated: $isAuthenticated)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.loginBackground)
        .ignoresSafeArea()
            
    }
    
}


#Preview {
    RootView()
}
