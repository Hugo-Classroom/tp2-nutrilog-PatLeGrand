//
//  LocalAuthentificationView.swift
//  NutriLog
//
//  Created by Patrick Aurel Monkam Ngaleu on 2025-11-06.
//

import SwiftUI
import LocalAuthentication

struct LocalAuthentificationView: View {
    
    
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        VStack {
            if isAuthenticated {
               HomeView()
            } else {
                Text ("Please Authenticate")
                    Button {
                    authentificate()
                        
                    } label: {
                        Text("Retry.")
                    }
            }
        }
        .onAppear(){
            authentificate()
        }
    }
    
    func authentificate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, error in
                if let error {
                    print (error)
                    return
                }
                if success {
                    print("Authentificated.")
                }
                   isAuthenticated = success
                }
            }
        }
    }

