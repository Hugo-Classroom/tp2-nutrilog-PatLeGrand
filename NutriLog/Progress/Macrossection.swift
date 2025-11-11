import SwiftUI

struct MacrosSection: View {
    let totalProtein: Double
    let totalCarbs: Double
    let totalFat: Double
    
    let dailyProteinGoal: Double = 150.0
    let dailyCarbsGoal: Double = 125.0
    let dailyFatGoal: Double = 100.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("MACROS")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
                .padding(.leading, 12)
            
            HStack(spacing: 35) {
                
                MacroCard(
                    icon: "circle.fill",
                    color: .red,
                    label: "Protéines",
                    labelLetter: "P",
                    value: totalProtein,
                    goal: dailyProteinGoal,
                    unit: "g"
                )
                
                MacroCard(
                    icon: "circle.fill",
                    color: .purple,
                    label: "Glucides",
                    labelLetter: "G",
                    value: totalCarbs,
                    goal: dailyCarbsGoal,
                    unit: "g"
                )
                
                MacroCard(
                    icon: "circle.fill",
                    color: .blue,
                    label: "Lipides",
                    labelLetter: "L",
                    value: totalFat,
                    goal: dailyFatGoal,
                    unit: "g"
                )
            }
            .frame(width: 350, height: 68, alignment: .leading)
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.vertical, 4)
            .background(.white)
            .cornerRadius(10)
        }
    }
}

struct MacroCard: View {
    let icon: String
    let color: Color
    let label: String
    let labelLetter : String
    let value: Double
    let goal: Double
    let unit: String
    
    var progress: Double {
        min(value / goal, 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack{
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 15, height: 15)
                    Text(labelLetter)
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                        .padding(1)
                    
                }
                
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(color)
            }
            
            ProgressView(value: progress)
                .tint(color)
                .frame(height: 4)
                .padding(.top, 2)
            
            Text(String(format: "%.0f", value))
                .font(.system(size: 14, weight: .bold))
            + Text(" ") +
            Text(String(format: "/ %.0f%@", goal, unit))
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
            
        }
    }
}

#Preview {
    MacrosSection(
        totalProtein: 127,
        totalCarbs: 105,
        totalFat: 35
    )
}
