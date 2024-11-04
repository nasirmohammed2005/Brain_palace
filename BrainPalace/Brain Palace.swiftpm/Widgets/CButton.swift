import SwiftUI

struct CButton: View {
    var title: String
    var image: String
    var action: () -> Void = {}
    
    var body: some View {
        if title.isEmpty {
            Button(action: self.action) {
                Image(systemName: "\(self.image)")
                    .font(.title)
                    .frame(width: 50, height:50)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
        } else {
            Button(action: self.action) {
                if !image.isEmpty {
                    Image(systemName: "\(self.image)")
                        .padding(.leading, 20)
                    Text("\(self.title)")
                        .padding(.trailing, 20)
                } else {
                    Text("\(self.title)")
                        .padding([.leading, .trailing], 20)
                }
            }
            .frame(height:50)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
    }
}
