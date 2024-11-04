import SwiftUI

struct FlashCard: Identifiable, Hashable, Codable {
    var id = UUID()
    var front: String
    var back: String
}

enum StackType {
    case hard
    case easy
    case good
}

class FlashCards: ObservableObject {
    
    @Published var flashCards:[FlashCard] = [
        FlashCard(front:"What is the powerhouse of the cell🔋", back:"The Mitochondria"),
        FlashCard(front:"Where does the light phase of photosynthesis take place in?", back:"The thalakoid"),
        FlashCard(front:"What is the most abundant element in humans?", back:"Oxygen"),
        FlashCard(front:"What is the simplest form of carbohydrate?", back:"Monohydrate"),
        FlashCard(front:"\"Bb\" is example of what type of genotype?", back:"Heterozygoes"),
    ]
    
    // get card by ID
    func getById(_ id: UUID) -> FlashCard {
        let card = self.flashCards.first(where: {$0.id == id}) ?? self.flashCards[0]
        return card
    }
    
    // code to remove card
    func removeCard(_ id: UUID) {
        for (index, flashCard) in self.flashCards.enumerated() {
            if flashCard.id == id {
                self.flashCards.remove(at: index)
            }
        }
    }
    
    // update card
    func update(_ id: UUID, front f: String, back b: String) {
        if let index = flashCards.firstIndex(where: {$0.id == id}) {
            self.flashCards[index] = FlashCard(id: id, front: f, back: b)
        }
    }
    
    // code to add card
    func addCard(front f: String, back b: String) {
        let card = FlashCard(front: f, back: b)
        self.flashCards.append(card)
    }
}



