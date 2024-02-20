import SwiftUI

struct CanvasView: View {
    let images: [Image]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<images.count, id: \.self) { index in
                    images[index]
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                        .position(x: CGFloat(index * 50 + 50), y: CGFloat(index * 50 + 50))
                }
            }
        }
    }
}
