import SwiftUI
import SwiftData
import Charts

struct DailyChartsView: View {
    @Query(sort: \FoodEntry.date, order: .reverse) private var allEntries: [FoodEntry]
    
    var todayEntries: [FoodEntry] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return allEntries.filter { entry in
            calendar.isDate(entry.date, inSameDayAs: today)
        }
    }
    
    var caloriesByMeal: [(mealType: String, calories: Double, color: Color)] {
        let grouped = Dictionary(grouping: todayEntries, by: { $0.mealType })
        
        return MealType.allCases.map { mealType in
            let entries = grouped[mealType] ?? []
            let totalCalories = entries.reduce(0) { $0 + $1.calories }
            let color: Color = mealType == .breakfast ? .blue :
                               mealType == .lunch ? .green : .orange
            return (mealType.rawValue, totalCalories, color)
        }
    }
    
    var macroData: [(name: String, value: Double, color: Color)] {
        let totalProtein = todayEntries.reduce(0) { $0 + $1.protein }
        let totalCarbs = todayEntries.reduce(0) { $0 + $1.carbs }
        let totalFat = todayEntries.reduce(0) { $0 + $1.fat }
        
        return [
            ("Protéines", totalProtein, .red),
            ("Glucides", totalCarbs, .purple),
            ("Lipides", totalFat, .blue)
        ]
    }
    
    var topFoods: [(name: String, calories: Double)] {
        let foodGroups = Dictionary(grouping: todayEntries) { $0.food?.name ?? "Inconnu" }
        
        let foodCalories = foodGroups.map { (name, entries) -> (String, Double) in
            let totalCalories = entries.reduce(0) { $0 + $1.calories }
            return (name, totalCalories)
        }
        
        return foodCalories
            .sorted { $0.1 > $1.1 }
            .prefix(5)
            .map { ($0.0, $0.1) }
    }
    
    var totalCalories: Double {
        todayEntries.reduce(0) { $0 + $1.calories }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Graphiques")
                        .font(.system(size: 35, weight: .bold))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Calories par repas")
                            .font(.system(size: 18, weight: .semibold))
                        
                        if caloriesByMeal.allSatisfy({ $0.calories == 0 }) {
                            Text("Aucune donnée disponible")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 40)
                        } else {
                            Chart {
                                ForEach(caloriesByMeal, id: \.mealType) { item in
                                    BarMark(
                                        x: .value("Repas", item.mealType),
                                        y: .value("Calories", item.calories)
                                    )
                                    .foregroundStyle(item.color.gradient)
                                    .cornerRadius(8)
                                }
                            }
                            .frame(height: 200)
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .chartXAxis {
                                AxisMarks { value in
                                    AxisValueLabel {
                                        if let label = value.as(String.self) {
                                            Text(label)
                                                .font(.system(size: 12))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Macros totaux")
                            .font(.system(size: 18, weight: .semibold))
                        
                        if macroData.allSatisfy({ $0.value == 0 }) {
                            Text("Aucune donnée disponible")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 40)
                        } else {
                            HStack(spacing: 20) {
                               
                                Chart(macroData, id: \.name) { item in
                                    SectorMark(
                                        angle: .value("Valeur", item.value),
                                        innerRadius: .ratio(0.5),
                                        angularInset: 2
                                    )
                                    .foregroundStyle(item.color.gradient)
                                }
                                .frame(width: 160, height: 160)
                                
                        
                                VStack(alignment: .leading, spacing: 12) {
                                    ForEach(macroData, id: \.name) { item in
                                        HStack(spacing: 8) {
                                            Circle()
                                                .fill(item.color)
                                                .frame(width: 12, height: 12)
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(item.name)
                                                    .font(.system(size: 12, weight: .medium))
                                                Text(String(format: "%.1f g", item.value))
                                                    .font(.system(size: 11))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Distribution des aliments")
                            .font(.system(size: 18, weight: .semibold))
                        
                        if topFoods.isEmpty {
                            Text("Aucune donnée disponible")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 40)
                        } else {
                            Chart {
                                ForEach(topFoods, id: \.name) { item in
                                    BarMark(
                                        x: .value("Calories", item.calories),
                                        y: .value("Aliment", item.name)
                                    )
                                    .foregroundStyle(Color.orange.gradient)
                                    .cornerRadius(6)
                                }
                            }
                            .frame(height: CGFloat(max(150, topFoods.count * 40)))
                            .chartXAxis {
                                AxisMarks(position: .bottom) { value in
                                    AxisValueLabel {
                                        if let calories = value.as(Double.self) {
                                            Text("\(Int(calories))")
                                                .font(.system(size: 10))
                                        }
                                    }
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading) { value in
                                    AxisValueLabel {
                                        if let label = value.as(String.self) {
                                            Text(label)
                                                .font(.system(size: 12))
                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    VStack(spacing: 8) {
                        Text("Total de la journée")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Text(String(format: "%.0f", totalCalories))
                            .font(.system(size: 36, weight: .bold))
                        + Text(" kcal")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(16)
            }
            .background(Color(.systemGray6))

            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DailyChartsView()
        .modelContainer(for: [Food.self, FoodEntry.self], inMemory: true)
}
