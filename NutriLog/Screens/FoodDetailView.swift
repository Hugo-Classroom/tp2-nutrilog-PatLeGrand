import SwiftUI

struct FoodDetailView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack {
                    Text("89")
                    + Text(" cal")
                    
                    Spacer()
                     
                    VStack {
                        Text("1g")
                            .bold(true)
                        Text("Protéines")
                    }
                    
                    VStack {
                        Text("1g")
                            .bold(true)
                        Text("Glucides")
                    }

                    VStack {
                        Text("1g")
                            .bold(true)
                        Text("Lipides")
                    }
                }
                .padding(.bottom, 10)
                
                
                Text("Historique de consommation")
                    .font(.headline)
                HStack{
                    VStack{
                        Text("Diner")
                        Text("Date")
                    }
                    Spacer()
                    Text("100g")
                }
                .padding(.bottom, 10)
                
                HStack{
                    VStack{
                        Text("Diner")
                        Text("Date")
                    }
                    Spacer()
                    Text("100g")
                }
                
                Spacer()
                
            }
            
            .navigationTitle(Text("Food Detail"))
            .padding()
            
        }
        
        
        
        
    }
}

#Preview {
    FoodDetailView()
}
