import SwiftUI

struct FlashCardWidget: View {
    var flashCard: FlashCard
    @State var showAnswer: Bool = false
    var noAnswer: Bool = false
    
    var body: some View {
        ZStack {
            // back view
            if noAnswer == false {
                Text("\(self.flashCard.back)")
                    .frame(height: 130)
                    .frame(width: 187, alignment: .center)
                    .cornerRadius(17)
                    .background(Color.black.brightness(0.22))
                    .cornerRadius(17)
                    .rotationEffect(.degrees(3))
                    .offset(x: 10)
                    .onTapGesture {
                        self.showAnswer = false
                    }
                    .multilineTextAlignment(.center)
            }
            
            // front view
            if !self.showAnswer {
                Text("\(self.flashCard.front)")
                    .frame(maxHeight: 130)
                    .frame(width: 187, alignment: .center)
                    .padding(7)
                    .cornerRadius(17)
                    .background(Color.black.brightness(0.18))
                    .cornerRadius(17)
                    .onTapGesture {
                        if !noAnswer {
                            self.showAnswer = true
                        }
                    }
                    .multilineTextAlignment(.center)
            }
        }
    }
}
