import SwiftUI

struct CanvasView: View {
    let images: [Image]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading, content: {
                Rectangle().background(Color.white)
                ForEach(0..<images.count, id: \.self) { index in
                    
                    // let image = images[index]
                    let imagePosition = calculateImagePositions(canvasWidth: geometry.size.width, canvasHeight: geometry.size.height, column: 0, row: index, columns: 1, rows: 3)
                    
                    ImageContainerView(image: images[index])
                        .frame(width: imagePosition.width, height: imagePosition.height)
                        .position(x: imagePosition.x + imagePosition.width / 2.0, y: imagePosition.y + imagePosition.height / 2.0)
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


func calculateImagePositions(canvasWidth: CGFloat, canvasHeight: CGFloat, 
                             column: Int, row: Int,
                             columns: Int, rows: Int) -> ImagePosition {
    let imgWidth = canvasWidth / CGFloat(columns)
    let imgHeight = canvasHeight / CGFloat(rows)

    return ImagePosition(x: imgWidth * CGFloat(column), y: imgHeight * CGFloat(row),
                         width: imgWidth, height: imgHeight)
}
