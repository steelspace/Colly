import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [PhotoData]()

    var body: some View {
        NavigationStack {
            ZStack {
                CanvasView(photoData: selectedImages)
            }
            .toolbar {
                PhotosPicker("Select images", selection: $selectedItems, matching: .images)
            }
            .onChange(of: selectedItems) {
                Task {
                    selectedImages.removeAll()

                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            let photoData = getPhotoData(image: image)
                            if photoData != nil {
                                selectedImages.append(photoData!)
                            }
                        }
                    }
                }
            }
        }
    }
}

@MainActor func getPhotoData(image: Image) -> PhotoData? {
    let renderer = ImageRenderer(content: image)
    guard let nsImage = renderer.nsImage else {
        return nil
    }
    let width = nsImage.size.width
    let height = nsImage.size.height
    let aspectRatio = width / height
    return PhotoData(width: width, height: height, aspectRatio: aspectRatio, image: image)
}
