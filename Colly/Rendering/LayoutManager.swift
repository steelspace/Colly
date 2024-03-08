import Foundation
import os

let logger = Logger(subsystem: "Colly", category: "All")

func calculateImagePositions(renderLayout: RenderLayout,
                             canvasWidth: CGFloat,
                             canvasHeight: CGFloat,
                             columns: Int,
                             rows: Int) -> [ImagePosition] {

    var imagePositions = [ImagePosition]()
    
    var left = 0.0
    var top = 0.0
    
    let rowsData = splitByRows(renderData: renderLayout.renderData)
    let height = canvasHeight / CGFloat(rowsData.count)
    
    logger.debug("Canvas height = \(canvasHeight, privacy: .public)")
    logger.debug("Rows count = \(rowsData.count, privacy: .public)")
    logger.debug("Picture height = \(height, privacy: .public)")
    
    for rowData in rowsData {
        let widths = calculateActualWidthsInRow(boxWidth: canvasWidth,
                                                relativeWidths: rowData.renderData.map({ $0.widthRatio }))
        
        for i in 0...rowData.renderData.count - 1 {
            imagePositions.append(ImagePosition(x: left, y: top, width: widths[i], height: height))
            left += widths[i]
        }
        
        // new row
        top += height
        left = 0
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
    
    for row in rows.sorted(by: { $0 < $1 }) {
        let rowRenderData = renderData.filter({ $0.row == row }).sorted(by: { $0.indexInRow < $1.indexInRow })
        renderDataInRows.append(RowData(renderData: rowRenderData))
    }

    return renderDataInRows
}
