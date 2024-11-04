import SwiftUI

@main
struct MyApp: App {
    @StateObject var flashCards = FlashCards()
    var body: some Scene {
        WindowGroup{
            ContentView()
                .environmentObject(flashCards)
                .preferredColorScheme(.dark)
        }
    }
}
