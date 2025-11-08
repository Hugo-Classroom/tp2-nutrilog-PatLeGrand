import Foundation

extension MockData {
    static let foodEntries: [FoodEntry] = [
        
        FoodEntry(food: oatmeal, servingSize: 100, mealType: .breakfast),
        FoodEntry(food: banana, servingSize: 150, mealType: .breakfast),
        FoodEntry(food: greekYogurt, servingSize: 150, mealType: .breakfast),
        
      
        FoodEntry(food: proteinFood, servingSize: 150, mealType: .lunch),
        FoodEntry(food: rice, servingSize: 200, mealType: .lunch),
        FoodEntry(food: broccoli, servingSize: 100, mealType: .lunch),
        
     
        FoodEntry(food: grilledSalmon, servingSize: 180, mealType: .dinner),
        FoodEntry(food: sweetPotato, servingSize: 150, mealType: .dinner),
        FoodEntry(food: spinach, servingSize: 80, mealType: .dinner)
    ]
}
