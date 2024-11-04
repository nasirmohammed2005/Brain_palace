import SwiftUI


struct ReviewPage: View {
    
    @State var handStack:[FlashCard]
    @State var hardStack:[FlashCard] = []
    @State var goodStack:[FlashCard] = []
    @State var easyStack:[FlashCard] = []
    @State var showAnswer:Bool = false
    @State var isDone:Bool = false
    
    var body: some View {
        VStack {
            Text("\(!showAnswer ? handStack[0].front : handStack[0].back)")
                .frame(maxHeight: 320)
                .frame(maxWidth: 700, alignment: .center)
                .padding([.leading, .trailing], 30)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(17)
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Hard: \(self.hardStack.count), Good: \(self.goodStack.count), Easy: \(self.easyStack.count)")
            HStack(spacing: 15) {
                if showAnswer {
                    CButton(title: "Again", image: "", action: {
                        self.showAnswer.toggle()
                    })
                    CButton(title: "Hard", image: "", action: {
                        moveToStack(.hard)
                        self.showAnswer.toggle()
                    })
                    CButton(title: "Good", image: "", action: {
                        moveToStack(.good)
                        self.showAnswer.toggle()
                    })
                    CButton(title: "Easy", image: "", action: {
                        moveToStack(.easy)
                        self.showAnswer.toggle()
                    })
                } else {
                    CButton(title: "Show Answer", image: "eye.fill", action: {
                        self.showAnswer.toggle()
                    })
                }
            }
        }
        .padding(40)
        .alert(isPresented: $isDone) {
            Alert(title: Text("Good Job"), message: Text("You've successfully studied all flashcards. This calls for a celebration 🥳🎉🎊👏"), dismissButton: .default(Text("Hurray 🙌🙌🙌")))
        }
    }
    
    private func moveToStack(_ t: StackType) {
        let allStack = [self.hardStack, self.easyStack, self.goodStack]
        let stackTypes:[StackType] = [.hard, .easy, .good]
        if !self.hardStack.isEmpty || !self.easyStack.isEmpty || !self.goodStack.isEmpty {
            for innerArray in allStack {
                for ca in innerArray {
                    if ca.id == self.handStack[0].id {
                        removeFromStack(stackTypes[allStack.firstIndex(where: {$0.contains(ca)}) ?? 0], cardId: ca.id)
                    }
                }
            }
        }
        switch t {
        case .hard:
            self.hardStack.append(self.handStack[0])
        case .good:
            self.goodStack.append(self.handStack[0])
        case .easy:
            self.easyStack.append(self.handStack[0])
        }
        self.handStack.removeFirst()
        checkDone()
        checkEmpty()
    }
    
    private func checkDone() {
        if self.hardStack.isEmpty && self.goodStack.isEmpty {
            if self.easyStack.count >= self.handStack.count {
                self.isDone = true
                self.handStack = self.easyStack
                self.easyStack.removeAll()
            } 
        }
    }
    
    private func removeFromStack(_ t: StackType, cardId ci: UUID) {
        switch t {
        case .hard:
            self.hardStack.removeAll(where: {$0.id == ci})
        case .good:
            self.goodStack.removeAll(where: {$0.id == ci})
        case .easy:
            self.easyStack.removeAll(where: {$0.id == ci})
        }
    }
    
     private func checkEmpty() {
         if self.handStack.isEmpty {
            self.handStack += self.hardStack
            self.handStack += self.goodStack
            self.handStack += self.easyStack
        }
    }    
}
