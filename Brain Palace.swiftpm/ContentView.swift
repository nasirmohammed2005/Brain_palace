import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var flashCards:FlashCards
    @State var showAddDialogue = false
    @State var newQuestion = ""
    @State var newAnswer = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    HStack {
                        Text("Flash Cards")
                            .font(.largeTitle)
                        Spacer()
                        NavigationLink(destination: ARFlashCardPage()) {
                            Image(systemName: "arkit")
                                .font(.title)
                                .frame(width: 50, height:50)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    .frame(maxWidth: 500)
                    
                    CardListView(flashCards: self.flashCards)
                        .frame(maxHeight: 450)
                    
                    HStack {
                        NavigationLink(destination: ReviewPage(handStack: flashCards.flashCards)) {
                            HStack{
                                Image(systemName: "rectangle.fill.on.rectangle.angled.fill")
                                    .padding(.leading, 20)
                                Text("Revise")
                                    .padding(.trailing, 20)
                            }
                            .frame(height:50)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(12)
                        }
                        Spacer()
                        CButton(title: "", image: "plus", action: {
                            self.showAddDialogue.toggle()
                        })
                        .sheet(isPresented: $showAddDialogue, onDismiss: {
                            if !self.newAnswer.isEmpty && !self.newQuestion.isEmpty {
                                self.flashCards.addCard(front: self.newQuestion, back: self.newAnswer)
                            }
                        }) {
                            FormModalSheet(type: "Add", newQuestion: $newQuestion, newAnswer: $newAnswer)
                        }
                    }
                    .padding([.leading, .trailing], 20)
                    .frame(maxWidth: 600)
                }
                .frame(maxWidth: 670)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


