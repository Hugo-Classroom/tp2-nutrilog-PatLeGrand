import SwiftUI
import SwiftData

struct FoodDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Query(sort: \FoodEntry.date, order: .reverse) private var allEntries: [FoodEntry]
    
    let food: Food?
    
    var consumptionHistory: [(mealType: String, date: String, serving: String)] {
        guard let food = food else { return [] }
        
        let filtered = allEntries.filter { $0.food?.name == food.name }
        
        return filtered.map { entry in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "fr_FR")
            
            return (
                mealType: entry.mealType.rawValue,
                date: dateFormatter.string(from: entry.date),
                serving: String(format: "%.0f g", entry.servingSize)
            )
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                Text(food?.name ?? "Aliment")
                    .font(.system(size: 39, weight: .bold))
                    .padding(.top, -12)
                    .padding(.bottom, 4)
                
                HStack(spacing: 20) {

                    Text(String(format: "%.0f", food?.calories ?? 0))
                        .font(.system(size: 32))
                        .foregroundColor(.gray)
                    + Text(" cal")
                        .font(.system(size: 31))
                        .foregroundColor(.gray)
                
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text(String(format: "%.0fg", food?.protein ?? 0))
                            .font(.system(size: 16, weight: .bold))
                        Text("Protéines")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                        
                    VStack(alignment: .center) {
                        Text(String(format: "%.0fg", food?.carbs ?? 0))
                            .font(.system(size: 16, weight: .bold))
                        Text("Glucides")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                        
                    VStack(alignment: .center) {
                        Text(String(format: "%.0fg", food?.fat ?? 0))
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
                
                if consumptionHistory.isEmpty {
                    Text("Aucun repas enregistré")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.top, 12)
                } else {
                    VStack(spacing: 12) {
                        ForEach(consumptionHistory.indices, id: \.self) { index in
                            let item = consumptionHistory[index]
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
    FoodDetailView(food: MockData.banana)
        .modelContainer(for: [Food.self, FoodEntry.self], inMemory: true)
}
