import Foundation

func initialLayout(photoData: [PhotoData]) -> RenderLayout {
    let imagesPerRow = Int(sqrt(Double(photoData.count)))
    
    var renderData = [RenderData]()
    
    var row = 0
    var indexInRow = 0
    
    for photo in photoData {
        let render = RenderData(imageId: photo.imageId,
                                image: photo.image,
                                row: row,
                                indexInRow: indexInRow,
                                originalAspectRatio: photo.aspectRatio,
                                widthRatio: photo.aspectRatio)
        
        renderData.append(render)
        indexInRow += 1
        
        if indexInRow > imagesPerRow {
            indexInRow = 0
            row += 1
        }
    }
    
    return RenderLayout(renderData: renderData)
}
