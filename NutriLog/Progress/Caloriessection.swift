//
//  Caloriessection.swift
//  NutriLog
//
//  Created by Patrick Aurel Monkam Ngaleu on 2025-11-07.
//

import SwiftUI

struct CaloriesSection: View {
    let totalCaloriesConsumed: Double
    let remainingCalories: Double
    let dailyCalorieGoal: Double
    
    var calorieProgress: Double {
        totalCaloriesConsumed / dailyCalorieGoal
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("CALORIES")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Restantes")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.gray)
                    (
                        Text(String(format: "%.0f", remainingCalories))
                            .font(.system(size: 15, weight: .bold))
                        + Text(" cal")
                            .font(.system(size: 14, weight: .regular))
                    )
                }
                
                
                ZStack {
                    Circle()
                        .stroke(Color.green.opacity(0.3), lineWidth: 8)
                    
                    Circle()
                        .trim(from: 0, to: min(calorieProgress, 1.0))
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                   
                }
                .frame(width: 40, height: 30)
                
                
                Divider()
                    
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Consommées")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.gray)
                    (
                        Text(String(format: "%.0f", totalCaloriesConsumed))
                            .font(.system(size: 14, weight: .bold))
                        + Text(" cal")
                            .font(.system(size: 14, weight: .regular))
                    )
                    
                }
                
            }
            .frame(width: 350, height: 68, alignment: .leading)
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.vertical, 4)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        
    }
        
}

#Preview {
    CaloriesSection(
        totalCaloriesConsumed: 1214,
        remainingCalories: 1286,
        dailyCalorieGoal: 2500
    )
}
