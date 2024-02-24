import SwiftUI

struct SelectLayoutView: View {
    @Binding var selectedColumns: Int
    @Binding var selectedRows: Int
    
    let columnOptions = Array(1...5)
    let rowOptions = Array(1...5)
    
    var body: some View {
        VStack {
            Text("Select Columns and Rows")
                .font(.title)
                .padding()
            
            Form {
                Section(header: Text("Columns")) {
                    Picker("Columns", selection: $selectedColumns) {
                        ForEach(columnOptions, id: \.self) { column in
                            Text("\(column)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Rows")) {
                    Picker("Rows", selection: $selectedRows) {
                        ForEach(rowOptions, id: \.self) { row in
                            Text("\(row)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Spacer()
            
            Text("Selected Columns: \(selectedColumns), Rows: \(selectedRows)")
                .padding()
        }
        .padding()
    }
}

