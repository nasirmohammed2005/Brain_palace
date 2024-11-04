import SwiftUI

struct CardListView: View {
    @State var flashCards: FlashCards
    @State var frontToUpdate: String = ""
    @State var backToUpdate: String = ""
    @State var showEditDialogue: Bool = false
    let aColmn = [
        GridItem(.adaptive(minimum: 194))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: aColmn, spacing: 30) {
                ForEach(self.flashCards.flashCards, id:\.self) { fCard in
                    FlashCardWidget(flashCard: fCard)
                        .sheet(isPresented: $showEditDialogue, onDismiss: {
                            if !self.frontToUpdate.isEmpty || !self.backToUpdate.isEmpty {
                                self.flashCards.update(fCard.id, front: frontToUpdate, back: backToUpdate)
                            }
                        })  {
                            FormModalSheet(type: "Edit", newQuestion: $frontToUpdate, newAnswer: $backToUpdate)
                        }
                        .contextMenu {
                            Button(action: {
                                self.showEditDialogue = true
                            }) {
                                Label("Edit", systemImage: "pencil")
                            }
                            Button(role: .destructive, action: {
                                self.flashCards.removeCard(fCard.id)
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }.padding(.top, 6)
        }
    }
}
