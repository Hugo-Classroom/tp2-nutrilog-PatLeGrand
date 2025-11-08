import SwiftUI

struct FoodDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let foodName = "Banane"
    let calories = 89.0
    let protein = 1.0
    let carbs = 23.0
    let fat = 0.0
    
    let consumptionHistory: [(mealType: String, date: String, serving: String)] = [
        ("Diner", "8 octobre 2025", "100 g"),
        ("Déjeuner", "7 octobre 2025", "100 g")
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                
                Text(foodName)
                    .font(.system(size: 39, weight: .bold))
                    .padding(.top, -12)
                    .padding(.bottom, 4)
                
                HStack(spacing: 20) {

                    Text(String(format: "%.0f", calories))
                        .font(.system(size: 32))
                        .foregroundColor(.gray)
                    + Text(" cal")
                        .font(.system(size: 31))
                        .foregroundColor(.gray)
                
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text(String(format: "%.0fg", protein))
                            .font(.system(size: 16, weight: .bold))
                        Text("Protéines")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                        
                        
                        
                    VStack(alignment: .center) {
                        Text(String(format: "%.0fg", carbs))
                            .font(.system(size: 16, weight: .bold))
                        Text("Glucides")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                        
                        
                        
                    VStack(alignment: .center) {
                        Text(String(format: "%.0fg", fat))
                            .font(.system(size: 16, weight: .bold))
                        Text("Lipides")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    
                }
                .padding(.bottom, 10)
                
                
                Text("Historique de consommation")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 16)
                
                VStack(spacing: 12) {
                    ForEach(consumptionHistory, id: \.date) { item in
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.mealType)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                Text(item.date)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text(item.serving)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 13)
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
            }
            .padding(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 12, weight: .semibold))
                            Text("Aujourd'hui")
                                .font(.system(size: 14, weight: .regular))
                        }
                        .foregroundColor(.orange)
                    }
                }
            }
          
        }
    }
}

#Preview {
    FoodDetailView()
}
