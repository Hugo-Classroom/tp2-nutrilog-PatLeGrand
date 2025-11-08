import SwiftUI
import SwiftData

struct AddMealView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    
    @State var selectedFood: Food? = nil
    @State var servingSize: Double = 120
    @State var selectedMealType: MealType = .breakfast
    
    let foods = MockData.foods
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Ajouter une entrée")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.clear)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    Picker("Aliment", selection: $selectedFood) {
                        Text("Choisir un aliment").tag(nil as Food?)
                        ForEach(foods, id: \.name) { food in
                            Text(food.name).tag(Optional(food))
                        }
                    }
                    .pickerStyle(.menu)
                    
                    
                    if selectedFood != nil {
                        
                        HStack {
                            Text("Portions: \(Int(servingSize)) g")
                                .font(.system(size: 14, weight: .regular))
                            
                            Spacer()
                            
                            HStack(spacing: 3) {
                                Button(action: {
                                    if servingSize > 10 {
                                        servingSize -= 10
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .frame(width: 30, height: 30)
                                        .background(Color(.systemGray5))
                                        .padding(.horizontal, 4)
                                }
                                
                                Divider()
                                
                                Button(action: {
                                    if servingSize < 500 {
                                        servingSize += 10
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                        .frame(width: 30, height: 30)
                                        .background(Color(.systemGray5))
                                        .padding(.horizontal, 4)
                                }
                            }
                            .background(Color(.systemGray5))
                            .cornerRadius(6)
                        }
                        .padding(.bottom, 8)
                        
                        
                        HStack(spacing: 0) {
                            ForEach(MealType.allCases) { mealType in
                                Button(action: { selectedMealType = mealType }) {
                                    Text(mealType.rawValue)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 8)
                                        .background(selectedMealType == mealType ? Color.white : Color(.systemGray5))
                                        .cornerRadius(15)
                                }
                                
                                if mealType != MealType.allCases.last {
                                    Divider()
                                        .frame(height: 24)
                                }
                            }
                        }
                        .padding(.vertical, 1)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Macros pour \(Int(servingSize)) g")
                                .font(.system(size: 14, weight: .semibold))
                            
                            HStack {
                                Text("Calories:")
                                    .font(.system(size: 13, weight: .regular))
                                Spacer()
                                Text(String(format: "%.1f kcal", (selectedFood?.calories ?? 0) * servingSize / 100))
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            
                            HStack {
                                Text("Protéines:")
                                    .font(.system(size: 13, weight: .regular))
                                Spacer()
                                Text(String(format: "%.1f g", (selectedFood?.protein ?? 0) * servingSize / 100))
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            
                            HStack {
                                Text("Glucides:")
                                    .font(.system(size: 13, weight: .regular))
                                Spacer()
                                Text(String(format: "%.1f g", (selectedFood?.carbs ?? 0) * servingSize / 100))
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            
                            HStack {
                                Text("Gras:")
                                    .font(.system(size: 13, weight: .regular))
                                Spacer()
                                Text(String(format: "%.1f g", (selectedFood?.fat ?? 0) * servingSize / 100))
                                    .font(.system(size: 13, weight: .semibold))
                            }
                        }
                        .padding(12)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    }
                }
                .padding(16)
            }
            
            Button(action: {
                saveMeal()
            }) {
                Text("Sauvegarder")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(selectedFood == nil ? Color.gray : Color.orange)
                    .cornerRadius(8)
            }
            .disabled(selectedFood == nil)
            .padding(16)
        }
    }
    

    private func saveMeal() {
        guard let selectedFood = selectedFood else { return }
        

        let newEntry = FoodEntry(
            food: selectedFood,
            servingSize: servingSize,
            mealType: selectedMealType,
            date: Date()
        )
        

        modelContext.insert(newEntry)
        

        do {
            try modelContext.save()
            print("✅ Repas sauvegardé avec succès!")
        } catch {
            print("❌ Erreur lors de la sauvegarde: \(error)")
        }
        
        isPresented = false
    }
}

#Preview {
    AddMealView(isPresented: .constant(true))
        .modelContainer(for: [Food.self, FoodEntry.self], inMemory: true)
}
