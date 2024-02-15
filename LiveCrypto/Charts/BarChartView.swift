//
//  BarChartView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import SwiftUI
import Charts

struct BarChartView: View {
    
    let data: [CryptoHistorycalResponse]
    let minValue: Double
    let maxValue: Double
    
    var body: some View {
        
        Chart(data, id: \.timestamp) { chartInfo in
            
            BarMark(
                x: .value("Close", chartInfo.id),
                yStart: .value("Low", chartInfo.temp(type: .low)),
                yEnd: .value("High", chartInfo.temp(type: .high)),
                width: 10
            )
            .foregroundStyle(
                Gradient(
                    colors: [
                        Color.green,
                        Color.red
                    ]
                )
            )
            RectangleMark(
                x: .value("Day", chartInfo.id),
                y: .value("Price", chartInfo.close),
                width: 2,
                height: 2
            )
            .foregroundStyle(Color.blue)
        }.frame(height: 300)
            .padding()
            .chartXAxis {
                AxisMarks(values: .stride(by: .day))
            }
            .chartXAxisLabel("Day")
            .chartYAxisLabel("Price in €")
            .chartForegroundStyleScale([
                CryptoHistorycalPriceTypes.close.rawValue: Color.blue,
                CryptoHistorycalPriceTypes.low.rawValue: Color.red,
                CryptoHistorycalPriceTypes.high.rawValue: Color.green
            ])
            .chartScrollableAxes(.horizontal)
            .chartYScale(domain: minValue...maxValue)
    }
}
