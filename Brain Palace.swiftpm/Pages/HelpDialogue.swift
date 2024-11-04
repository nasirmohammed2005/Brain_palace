import SwiftUI

struct HDListText: View {
    var number: String
    var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(self.number). ")
                .font(.body)
                .foregroundColor(.gray)
            Text("\(self.text)")
                .font(.body)
        }
        .padding(.bottom, 5)
        .padding([.leading, .trailing], 20)
    }
}

struct HelpDialogue: View {
    @Environment(\.presentationMode) var presentation
    @Binding var showHelpDialogue: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("What it is")
                        .font(.title3.bold())
                        .padding(.bottom, 10)
                        .padding(.top, 20)
                        .padding([.leading, .trailing], 20)
                    
                    Text("The technique of memorizing by associating mental images with physical locations, known as the memory palace, can be a useful tool when learning new stuff. In this app with flash cards, you can create your own virtual memory palace, using the AR space as the physical location and the flash cards as the mental images, combining the best of both worlds, flash cards and the memory palace")
                        .font(.body)
                        .padding(.bottom, 5)
                        .padding([.leading, .trailing], 20)
                    
                    Text("How to use")
                        .font(.title3.bold())
                        .padding(.bottom, 5)
                        .padding(.top, 20)
                        .padding([.leading, .trailing], 20)
                    HDListText(number: "1", text: "Look around with your device's camera until you find a suitable surface where you want to place the flash cards")
                    HDListText(number: "2", text: "Scroll through the list of flash cards at the bottom of the screen and tap on one that you want to add to the scene")
                    HDListText(number: "3", text: "Once the flash card is added, a sphere will appear on the surface.")
                    HDListText(number: "4", text: "Tap on the sphere to see the flash card you put on that spot")
                    HDListText(number: "5", text: "After reading the flashcard, tap the x mark on the top left or anywhere outside the flash card to close the window")
                }
            }
            .navigationBarTitle("Help")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done", action: {
                self.showHelpDialogue = false
                self.presentation.wrappedValue.dismiss()
            }))
        }
    }
}
