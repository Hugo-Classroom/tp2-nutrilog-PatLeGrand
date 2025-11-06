import SwiftUI

struct DailySummaryView: View {
    @State var reminingCalorieProgress: Double = 1
    
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
                    CircularProgressView(progress: reminingCalorieProgress)
                    
                }
                
                
            }
            .toolbar {
                
                Button {
                    
                }
                label: {
                    Image(systemName: "plus")
                        .tint(Color(.orange))
                }
            }
            .navigationTitle(Text("Aujourd'hui"))
        }
        
    }
}

#Preview {
    DailySummaryView()
}
