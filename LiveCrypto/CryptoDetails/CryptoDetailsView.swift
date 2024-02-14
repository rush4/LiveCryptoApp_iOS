//
//  CryptoDetailsView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import SwiftUI
import Charts

struct CryptoDetailsView: View {
    @ObservedObject var viewModel = CryptoDetailsViewModel()
    
    @State var chartType: PricesChartType = .line
    
    let cryptoId: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                switch viewModel.cryptoDetailsntent {
                    
                case .loading:
                    ProgressView().onAppear(perform: {
                        viewModel.fetchDetails(cryptoId ?? "")
                    })
                case .fetchedCryptoDetails(let details, let historycal):
                    
                    VStack {
                        HStack{
                            if let url = URL(string: details?.image.large ?? "") {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                            } else {
                                Text("Invalid URL")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.red)
                            }
                            Text(details?.name ?? "")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                        }
                        
                        if historycal != nil {
                            
                            Divider()
                            
                            Picker("Chart Type", selection: $chartType.animation(.easeInOut)) {
                                Text("Line").font(.title).fontWeight(.semibold).tag(PricesChartType.line)
                                Text("Bar").font(.title).fontWeight(.semibold).tag(PricesChartType.bar)
                            }
                              .pickerStyle(.segmented)
                            
                            let maxValue = historycal?.map({ item in
                                item.high
                            }).max() ?? 0
                            
                            let minValue = historycal?.map({ item in
                                item.low
                            }).min() ?? 0
                            
                            Text("Price Chart")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.purple)
                                .padding()
                            Divider()
                            
                            switch chartType {
                                
                            case.bar:
                                BarChartView(data: historycal ?? [], minValue: minValue, maxValue: maxValue)
                            case .line:
                                
                                LineChartView(data: historycal ?? [], minValue: minValue, maxValue: maxValue)
                            }
                        } else {
                            ErrorView()
                        }
                        Divider()
                        
                        if details != nil {
                            
                            Text("History")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                                .multilineTextAlignment(.leading)
                                    
                            Text(details?.description.en.stringByStrippingHTML() ?? "")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(Color.indigo)
                                .multilineTextAlignment(.leading)
                            
                            Divider()
                            
                            let website = details?.links.homepage.first ?? ""
                            
                            Link(website , destination: (URL(string: website) ?? URL(string: "www.mooney.it"))!)
                                .font(.body)
                        } else {
                            
                            ErrorView()
                        }
                        
                        Divider()
                        
                    }
                    .padding(.all)
                }
            }
        }
    }
}

struct LineChartView: View {
    
    let data: [CryptoHistorycalResponse]
    let minValue: Double
    let maxValue: Double
    @State var closePrice: Double?
    
    var body: some View {
        
        Chart(data, id: \.timestamp) { chartInfo in
            
            LineMark(
                x: .value("Day", chartInfo.id),
                y: .value("Prices", chartInfo.close)
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
//        Text("\(closePrice)")
    }
}

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
                width: 5,
                height: 5
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


#Preview {
    CryptoDetailsView(cryptoId: "bitcoin")
}
