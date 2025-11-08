import SwiftUI
import SwiftData

@main
struct NutriLogApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [Food.self, FoodEntry.self])
    }
}
