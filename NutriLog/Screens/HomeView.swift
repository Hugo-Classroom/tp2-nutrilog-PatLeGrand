import SwiftUI
import SwiftData

struct HomeView: View {
    var body: some View {
        TabView {
            DailySummaryView()
                .tabItem {
                    Image(systemName: "sun.max")
                    Text("Journée")
                        .tint(.tabViewButton)
                    
                }
            Spacer()
            Spacer()
            DailyChartsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Graphiques")
                        .tint(.tabViewButton)
                    
                }
        }
        .accentColor(Color(.orange))
    }
}

#Preview {
    HomeView()
        .modelContext(PersistenceController.preview.context)
}
