import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @Binding var isAuthenticated: Bool   // 👈 vient maintenant de l’extérieur
    
    var body: some View {
        Color.loginBackground.ignoresSafeArea()
            .overlay(
                VStack(spacing: 0) {
                    Image("nutrilog-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Button {
                        authentificate()
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
    
    func authentificate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, authError in
                // ⚠️ On revient potentiellement sur un thread en arrière-plan
                DispatchQueue.main.async {
                    if let authError {
                        print("Erreur FaceID/TouchID: \(authError.localizedDescription)")
                        return
                    }
                    
                    if success {
                        print("Authentifié ✅")
                        isAuthenticated = true   // 👈 met à jour RootView
                    } else {
                        print("Échec de l'authentification ❌")
                    }
                }
            }
        } else {
            print("Biométrie non disponible : \(error?.localizedDescription ?? "Inconnue")")
        }
    }
}
