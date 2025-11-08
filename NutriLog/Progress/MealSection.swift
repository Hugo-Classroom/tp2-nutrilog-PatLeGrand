//
//  MealSection.swift
//  NutriLog
//
//  Created by Patrick Aurel Monkam Ngaleu on 2025-11-07.
//

import SwiftUI

struct MealSection: View {
    let mealType: MealType
    let entries: [FoodEntry]
    let totalCalories: Double
    let hasMacros: (protein: Bool, carbs: Bool, fat: Bool)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Text(mealType.rawValue.uppercased())
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.gray)
                
                Spacer()
                
                HStack(spacing: 4) {
                    if hasMacros.protein {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 20, height: 20)
                            Text("P")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    if hasMacros.carbs {
                        ZStack {
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 20, height: 20)
                            Text("G")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                    if hasMacros.fat {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 20, height: 20)
                            Text("L")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }

                
                Text(String(format: "%.0f CAL", totalCalories))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 12) {
                ForEach(entries, id: \.id) { entry in
                    FoodItemCard(
                        food: entry.food,
                        calories: entry.calories
                    )
                }
            }
        }
    }
}

#Preview {
    MealSection(
        mealType: .breakfast,
        entries: [MockData.foodEntries[0]],
        totalCalories: 200,
        hasMacros: (protein: true, carbs: true, fat: false)
    )
}
