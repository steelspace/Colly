import SwiftUI
import PhotosUI

struct CollageView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0..<selectedImages.count, id: \.self) { i in
                        selectedImages[i]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
            }
            .toolbar {
                PhotosPicker("Select images", selection: $selectedItems, matching: .images)
            }
            .onChange(of: selectedItems) {
                Task {
                    selectedImages.removeAll()

                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CollageView()
}
