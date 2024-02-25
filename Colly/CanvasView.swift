import SwiftUI

struct CanvasView: View {
    let renderLayout: RenderLayout
    let canvasData: CanvasData
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing, content: {
                let imagePositions = calculateImagePositions(renderLayout: renderLayout,
                                                             canvasWidth: geometry.size.width,
                                                             canvasHeight: geometry.size.height,
                                                             columns: canvasData.columns,
                                                             rows: canvasData.rows)
                Rectangle().background(Color.white)
                
                ForEach(0..<renderLayout.renderData.count, id: \.self) { index in
                    
                    let imagePosition = imagePositions[index]
                                       
                    ImageContainerView(image: renderLayout.renderData[index].image)
                        .frame(width: imagePosition.width, height: imagePosition.height)
                        .position(x: imagePosition.x + imagePosition.width / 2.0,
                                  y: imagePosition.y + imagePosition.height / 2.0)
                }
            })
        }
    }
}

/*
func calculateImagePositions(photoData: [PhotoData],
                             canvasWidth: CGFloat,
                             canvasHeight: CGFloat,
                             columns: Int,
                             rows: Int) -> [ImagePosition] {
    let widths = calculateRectanglesWidths(boxWidth: canvasWidth, relativeWidths: photoData.map { $0.aspectRatio })
    var imagePositions = [ImagePosition]()
    
    var i = 0
    var left = 0.0
    var column = 0
    var row = 0
    
    var prevRowHeight = 0.0
    
    let actualRows = Double(photoData.count) / Double(columns)
    
    for photo in photoData {
        var width = widths[i]
        var height = width / photo.aspectRatio
        
        if height * actualRows > canvasHeight {
            height = canvasHeight / actualRows
            width = height * photo.aspectRatio
        }
        
        let y = prevRowHeight
        let x = left
        
        imagePositions.append(ImagePosition(x: x, y: y,
                                            width: width, height: height))
        left += width
        i += 1
        column += 1
        
        if column >= columns {
            left = 0.0
            prevRowHeight = height
            column = 0
            row += 1
        }
    }

    return imagePositions
}

func calculateRectanglesWidths(boxWidth: Double, relativeWidths: [Double]) -> [Double] {
    let totalRelativeWidth = relativeWidths.reduce(0, +)
    return relativeWidths.map { ($0 / totalRelativeWidth) * boxWidth }
}
*/
