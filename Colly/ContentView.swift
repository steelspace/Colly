import PhotosUI
import SwiftUI

struct ContentView: View {
    @State var selectedColumns = 3
    @State var selectedRows = 3

    @State private var selectedItems = [PhotosPickerItem]()
    @State private var layout = RenderLayout(renderData: [RenderData]())
    @State private var show = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                CanvasView(renderLayout: layout, canvasData: CanvasData(columns: selectedColumns, rows: selectedRows))
            }
            .toolbar {
                Button(action: {
                    self.show = true
                }) {
                    HStack {
                        Image(systemName: "star")
                        Text("Tap me!")
                    }
                }
                .popover(isPresented: self.$show,
                         attachmentAnchor: .point(.center),
                         arrowEdge: .top,
                         content: {
                    SelectLayoutView(selectedColumns: $selectedColumns, selectedRows: $selectedRows)
                        .presentationCompactAdaptation(.none)
                })
                PhotosPicker("Select images", selection: $selectedItems, matching: .images)
            }
            .onChange(of: selectedItems) {
                Task {
                    var selectedImages = [PhotoData]()
                    
                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            let photoData = getPhotoData(image: image)
                            if photoData != nil {
                                selectedImages.append(photoData!)
                            }
                        }
                    }
                    
                    layout = initialLayout(photoData: selectedImages)
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
    let uuid = UUID().uuidString
    
    return PhotoData(width: width, height: height, aspectRatio: aspectRatio, imageId: uuid, image: image)
}
