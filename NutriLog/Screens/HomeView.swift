import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            if selectedTab == 0 {
                DailySummaryView()
            } else {
                DailyChartsView()
            }
            
            Spacer()
            
            HStack(spacing: 40) {
                Button(action: { selectedTab = 0 }) {
                    VStack(spacing: 3) {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 25, weight: .bold))
                        Text("Journée")
                    }
                    .foregroundColor(selectedTab == 0 ? .orange : .gray)
                }
                
                Spacer()
                
                Button(action: { selectedTab = 1 }) {
                    VStack(spacing: 3) {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 25, weight: .bold))
                        Text("Graphiques")
                    }
                    .foregroundColor(selectedTab == 1 ? .orange : .gray)
                }
                
                
            }
            
            .padding(.horizontal, 65)
            
        }
        .padding(.bottom, 15)
        .background(Color(.systemGray6))
        
    }
        
}

#Preview {
    HomeView()
        .modelContext(PersistenceController.preview.context)
}
