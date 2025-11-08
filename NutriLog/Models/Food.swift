import Foundation
import SwiftData

@Model
class Food {
    var name: String
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
    var desc: String? = nil

    init(name: String, calories: Double, protein: Double, carbs: Double, fat: Double, desc: String? = nil) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.desc = desc
    }
}
