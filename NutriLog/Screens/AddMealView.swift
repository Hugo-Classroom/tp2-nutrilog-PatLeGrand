import SwiftUI



struct ContentView: View {
    @State var showSheet = true
    
    var body: some View {
        Button("Ajouter une entrée") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            AddMealView(isPresented: $showSheet)
        }
    }
}

struct AddMealView: View {
    @Binding var isPresented: Bool
        
        var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Chocolat noir (70%)")
                        .font(.headline)
                    
                    HStack {
                        Text("Portions: 120 g")
                        Spacer()
                        HStack(spacing: 10) {
                            Button(action: {}) {
                                Text("−")
                            }
                            Button(action: {}) {
                                Text("+")
                            }
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button("Déjeuner") { }
                        Button("Dîner") { }
                        Button("Souper") { }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Macros pour 120 g").font(.headline)
                        Text("Calories: 717.6 kcal")
                        Text("Protéines: 9.4 g")
                        Text("Glucides: 55.2 g")
                        Text("Gras: 50.4 g")
                    }
                    
                    Spacer()
                    
                    Button("Sauvegarder") {
                        isPresented = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                .navigationTitle("Ajouter une entrée")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { isPresented = false }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
/*
 #Preview {
 AddMealView()
 }
 */
