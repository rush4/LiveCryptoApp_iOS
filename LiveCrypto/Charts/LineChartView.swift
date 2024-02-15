//
//  LineChartView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import SwiftUI
import Charts

struct LineChartView: View {
    
    let data: [CryptoHistorycalResponse]
    let minValue: Double
    let maxValue: Double
    @State var closePrice: Double?
    
    var body: some View {
        
        Chart(data, id: \.timestamp) { chartInfo in
            
            LineMark(
                x: .value("Day", chartInfo.id),
                y: .value("Price", chartInfo.close)
            ).foregroundStyle(Color.blue)
                .symbol(.circle)
                .interpolationMethod(.catmullRom)
        }.chartXAxisLabel("Day", alignment: .center)
            .chartYAxisLabel("Price in €")
            .chartXAxis {
                AxisMarks(values: .stride(by: .day))
            }
            .chartYAxis {
                AxisMarks( preset: .automatic, position: .leading)
            }
            .chartScrollableAxes(.horizontal)
            .chartYScale(domain: minValue...maxValue)
            .frame(height: 300)
            .padding()
    }
}
