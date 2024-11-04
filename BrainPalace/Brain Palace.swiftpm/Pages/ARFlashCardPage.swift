import SwiftUI
import RealityKit
import ARKit

struct TopControlls: View {
    @Environment(\.presentationMode) var presentation
    @State var showHelpDialogue: Bool = false
    
    var body: some View {
        
        HStack(alignment: .top) {
            CButton(title: "", image: "chevron.left", action: {
                self.presentation.wrappedValue.dismiss()
            })
            
            Spacer()
            
            CButton(title: "", image: "questionmark.circle", action: {
                self.showHelpDialogue = true
            })
            .sheet(isPresented: $showHelpDialogue) {
                HelpDialogue(showHelpDialogue: $showHelpDialogue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.leading, .trailing], 17)
        .padding(.top, 30)
    }
}

struct ARFlashCardPage: View {
    @State var selectedCard: String = ""
    @State var confirmPlacing:Bool = false
    @State var fCardId: UUID?
    @EnvironmentObject var flashCards: FlashCards
    @State var selectedCarousel: UUID = UUID()
    
    var body: some View {
        GeometryReader { geometryInsets in 
            ZStack(alignment: .bottomTrailing) {                
                ARViewContainer(fCardId: $fCardId, confirmPlacing: $confirmPlacing, cardToPlace: $selectedCard)
                
                // Top Controlls
                TopControlls()
                    
                // Cards carousel
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.flashCards.flashCards, id:\.self) { fCard in 
                            Text("\(fCard.front)")
                                .frame(maxHeight: 130)
                                .frame(width: 187, alignment: .center)
                                .padding(7)
                                .cornerRadius(17)
                                .background(Color.black.brightness(0.18))
                                .onTapGesture {
                                    self.confirmPlacing = true
                                    self.selectedCard = fCard.id.uuidString
                                }
                        }
                        .cornerRadius(17)
                        .multilineTextAlignment(.center)
                    }
                    .padding(.leading, 17)
                    .padding(.bottom, geometryInsets.safeAreaInsets.bottom+20)
                }
                .frame(height: 180+geometryInsets.safeAreaInsets.bottom, alignment: .bottomLeading)
                .background(Color.black.opacity(0.5))
                
                if fCardId != nil {
                    GeometryReader { gp in
                        BlurView(style: .systemThinMaterialDark)
                    }
                    .onTapGesture {
                        self.fCardId = nil
                    }

                    FlashCardWidget(flashCard: self.flashCards.getById(fCardId ?? UUID()))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CButton(title: "", image: "xmark", action: {
                        self.fCardId = nil
                    })
                    .padding(.trailing, 40)
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                } 
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }    
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var fCardId: UUID?
    @Binding var confirmPlacing: Bool
    @Binding var cardToPlace: String
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        context.coordinator.view = arView
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        arView.session.run(config)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if self.confirmPlacing == true {
            let anchorEntity = AnchorEntity(plane: .any)
            let sphereMesh = MeshResource.generateSphere(radius: 0.04)
            let sphereMaterial = SimpleMaterial(color: .systemPink, isMetallic: false)
            let sphere = ModelEntity(mesh: sphereMesh, materials: [sphereMaterial])
            sphere.generateCollisionShapes(recursive: true)
            sphere.name = "\(cardToPlace)"
            
            anchorEntity.addChild(sphere)
            uiView.scene.addAnchor(anchorEntity)
            
            DispatchQueue.main.async {
                self.confirmPlacing = false
                self.cardToPlace = ""
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(tappedCard: $fCardId)
    }
}
