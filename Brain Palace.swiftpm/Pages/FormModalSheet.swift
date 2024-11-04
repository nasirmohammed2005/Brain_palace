import SwiftUI

struct FormModalSheet: View {
    
    @Binding var newQuestion: String
    @Binding var newAnswer: String
    var type: String
    @Environment(\.presentationMode) var pMode
    
    init(type t: String, newQuestion nq: Binding<String>, newAnswer na: Binding<String>) {
        _newQuestion = nq
        _newAnswer = na
        type = t
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Front side") {
                    TextField("Enter your question", text: $newQuestion)
                }
                Section("Back side") {
                    TextField("Enter the answer", text: $newAnswer)
                }
            }
            .navigationBarTitle("\(type) card")
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    self.pMode.wrappedValue.dismiss()
                }),
                trailing: Button("\(type)", action: {
                    self.pMode.wrappedValue.dismiss()
                }).disabled(newQuestion.isEmpty && newAnswer.isEmpty)
            )
        }
    }
}
