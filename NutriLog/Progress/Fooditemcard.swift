//
//  Fooditemcard.swift
//  NutriLog
//
//  Created by Patrick Aurel Monkam Ngaleu on 2025-11-07.
//

import SwiftUI

struct FoodItemCard: View {
    let food: Food?
    let calories: Double
    
    var body: some View {
        NavigationLink(destination: FoodDetailView(food: food)) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(food?.name ?? "Unknown")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(food?.desc ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Text(String(format: "%.0f kcal", calories))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.gray)
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

#Preview {
    FoodItemCard(
        food: MockData.banana,
        calories: 89
    )
}
