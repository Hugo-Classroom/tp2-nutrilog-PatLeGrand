import SwiftUI

struct DailySummaryView: View {
    @State var reminingCalorieProgress: Double = 0.5
    @State var showAddMealSheet = false
    
    var body: some View {
        NavigationView{
            VStack {
                
                HStack {
                    VStack{
                        Text("Restantes")
                            .bold(true)
                            .font(Font.system(size: 20))
                        (
                            Text("1,285 ")
                                .bold(true)
                                .font(Font.system(size: 20))
                            + Text ("cal")
                        )
                        .padding(4)
                        
                    }
                    
                }
                
                
            }
            .toolbar {
                
                Button {
                    showAddMealSheet = true  
                }
                label: {
                    Image(systemName: "plus")
                        .tint(Color(.orange))
                }
            }
            .sheet(isPresented: $showAddMealSheet) {
                AddMealView(isPresented: $showAddMealSheet)
            }
            .navigationTitle(Text("Aujourd'hui"))
        }
        
    }
}

#Preview {
    DailySummaryView()
}
