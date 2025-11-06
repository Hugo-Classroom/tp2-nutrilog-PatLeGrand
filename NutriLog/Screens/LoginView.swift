import SwiftUI

struct LoginView: View {
    var body: some View {
        Color.loginBackground.ignoresSafeArea()
            .overlay(
                VStack(spacing: 0) {
                    Image("nutrilog-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "faceid")
                        Text("Se connecter")
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(.loginButton)
        
                }
                
            )
        
        
    }
}

#Preview {
    LoginView()
}
