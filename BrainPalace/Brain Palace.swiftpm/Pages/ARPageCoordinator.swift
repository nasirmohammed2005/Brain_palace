import SwiftUI
import ARKit
import RealityKit

class Coordinator: NSObject {
    @Binding var fCardId: UUID?
    weak var view: ARView?
    
    init(tappedCard: Binding<UUID?>) {
        _fCardId = tappedCard
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        guard let view = self.view else { return }
        let tapLocation = sender.location(in: view)
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            fCardId = UUID(uuidString: entity.name)
        }
    }     
}
