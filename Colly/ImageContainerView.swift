import SwiftUI

struct ImageContainerView: View {
    let image: Image
    
    var body: some View {
        ZStack {
            image
                .resizable()
                .scaledToFit()
        }
        .padding(3)
        .cornerRadius(3)
        .overlay(
            RoundedRectangle(cornerRadius: 3)
            .stroke(.blue, lineWidth: 1)
        )
    }
}
