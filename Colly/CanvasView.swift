import SwiftUI

struct CanvasView: View {
    let photoData: [PhotoData]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing, content: {
                let imagePositions = calculateImagePositions(photoData: photoData,
                                                             canvasWidth: geometry.size.width,
                                                             canvasHeight: geometry.size.height,
                                                             columns: 3)
                Rectangle().background(Color.white)
                ForEach(0..<photoData.count, id: \.self) { index in
                    
                    let imagePosition = imagePositions[index]
                                       
                    ImageContainerView(image: photoData[index].image)
                        .frame(width: imagePosition.width, height: imagePosition.height)
                        .position(x: imagePosition.x + imagePosition.width / 2.0,
                                  y: imagePosition.y + imagePosition.height / 2.0)
                }
            })
        }
    }
}

struct ImagePosition {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
}

func calculateImagePositions(photoData: [PhotoData],
                             canvasWidth: CGFloat,
                             canvasHeight: CGFloat,
                             columns: Int) -> [ImagePosition] {
    let widths = calculateRectanglesWidths(boxWidth: canvasWidth, relativeWidths: photoData.map { $0.aspectRatio })
    var imagePositions = [ImagePosition]()
    
    var i = 0
    var left = 0.0
    for photo in photoData {
        var width = widths[i]
        var height = width / photo.aspectRatio
        
        if height > canvasHeight {
            height = canvasHeight
            width = height * photo.aspectRatio
        }
        
        let y = 0.0
        let x = left
        
        imagePositions.append(ImagePosition(x: x, y: y,
                                            width: width, height: height))
        left += width
        i += 1
    }

    return imagePositions
}

func calculateRectanglesWidths(boxWidth: Double, relativeWidths: [Double]) -> [Double] {
    let totalRelativeWidth = relativeWidths.reduce(0, +)
    return relativeWidths.map { ($0 / totalRelativeWidth) * boxWidth }
}
