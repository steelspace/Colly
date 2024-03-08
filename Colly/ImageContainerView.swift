import SwiftUI

struct ImageContainerView: View {
    let image: Image
    
    var body: some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .containerRelativeFrame([.horizontal, .vertical])
                .clipped()
        }
        .padding(10)
        .background(.white)
    }
}
