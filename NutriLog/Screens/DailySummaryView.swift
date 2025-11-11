import SwiftUI
import SwiftData

struct DailySummaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FoodEntry.date, order: .reverse) private var allEntries: [FoodEntry]
    
    @State var showAddMealSheet = false
    
    let dailyCalorieGoal = 2500.0
    let dailyProteinGoal = 150.0
    let dailyCarbsGoal = 125.0
    let dailyFatGoal = 100.0
    
    var todayEntries: [FoodEntry] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return allEntries.filter { entry in
            calendar.isDate(entry.date, inSameDayAs: today)
        }
    }
    
    var totalCaloriesConsumed: Double {
        todayEntries.reduce(0) { $0 + $1.calories }
    }
    
    var remainingCalories: Double {
        dailyCalorieGoal - totalCaloriesConsumed
    }
    
    var totalProtein: Double {
        todayEntries.reduce(0) { $0 + (($1.food?.protein ?? 0) * $1.servingSize / 100) }
    }
    
    var totalCarbs: Double {
        todayEntries.reduce(0) { $0 + (($1.food?.carbs ?? 0) * $1.servingSize / 100) }
    }
    
    var totalFat: Double {
        todayEntries.reduce(0) { $0 + (($1.food?.fat ?? 0) * $1.servingSize / 100) }
    }
    
    var entriesByMealType: [MealType: [FoodEntry]] {
        Dictionary(grouping: todayEntries, by: { $0.mealType })
    }
    
    func mealTypeCalories(_ mealType: MealType) -> Double {
        (entriesByMealType[mealType] ?? []).reduce(0) { $0 + $1.calories }
    }
    
    func hasMacro(_ mealType: MealType, macro: String) -> Bool {
        guard let entries = entriesByMealType[mealType] else { return false }
        for entry in entries {
            let value = macro == "protein" ? (entry.food?.protein ?? 0) * entry.servingSize / 100
                      : macro == "carbs" ? (entry.food?.carbs ?? 0) * entry.servingSize / 100
                      : (entry.food?.fat ?? 0) * entry.servingSize / 100
            if value > 0 { return true }
        }
        return false
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    Text("Aujourd'hui")
                        .font(.system(size: 35, weight: .bold))
                    
                    CaloriesSection(
                        totalCaloriesConsumed: totalCaloriesConsumed,
                        remainingCalories: remainingCalories,
                        dailyCalorieGoal: dailyCalorieGoal
                    )
                    
                    MacrosSection(
                        totalProtein: totalProtein,
                        totalCarbs: totalCarbs,
                        totalFat: totalFat
                    )
                    
                    ForEach([MealType.breakfast, MealType.lunch, MealType.dinner], id: \.id) { mealType in
                        if let entries = entriesByMealType[mealType], !entries.isEmpty {
                            MealSection(
                                mealType: mealType,
                                entries: entries,
                                totalCalories: mealTypeCalories(mealType),
                                hasMacros: (
                                    protein: hasMacro(mealType, macro: "protein"),
                                    carbs: hasMacro(mealType, macro: "carbs"),
                                    fat: hasMacro(mealType, macro: "fat")
                                )
                            )
                        }
                    }
                }
                .padding(16)
            }
            .background(Color(.systemGray6))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddMealSheet = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.orange)
                    }
                }
            }
            .sheet(isPresented: $showAddMealSheet) {
                AddMealView(isPresented: $showAddMealSheet)
            }
        }
        
        
    }
        
}

#Preview {
    DailySummaryView()
        .modelContainer(for: [Food.self, FoodEntry.self], inMemory: true)
}
