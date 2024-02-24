import Foundation

func calculateImagePositions(renderLayout: RenderLayout,
                             canvasWidth: CGFloat,
                             canvasHeight: CGFloat,
                             columns: Int,
                             rows: Int) -> [ImagePosition] {

    var imagePositions = [ImagePosition]()
    
    let rowsData = splitByRows(renderData: renderLayout.renderData)
    var left = 0.0
    var top = 0.0
    for rowData in rowsData {
        let widths = calculateActualWidthsInRow(boxWidth: canvasWidth,
                                                relativeWidths: rowData.renderData.map({ $0.widthRatio }))
        
        var i = 0
        for image in rowData.renderData {
            imagePositions.append(ImagePosition(x: left, y: top, width: widths[i], height: widths[i] * image.originalAspectRatio))
            i += 1
        }
    }
    
    return imagePositions
}

func calculateActualWidthsInRow(boxWidth: Double, relativeWidths: [Double]) -> [Double] {
    let totalRelativeWidth = relativeWidths.reduce(0, +)
    return relativeWidths.map { ($0 / totalRelativeWidth) * boxWidth }
}

func splitByRows(renderData: [RenderData]) -> [RowData] {
    var renderDataInRows = [RowData]()
    
    let rows = Set(renderData.map { $0.row })
    
    for row in rows {
        let rowRenderData = renderData.filter({ $0.row == row }).sorted(by: { $0.indexInRow < $1.indexInRow })
        renderDataInRows.append(RowData(renderData: rowRenderData))
    }

    return renderDataInRows
}
