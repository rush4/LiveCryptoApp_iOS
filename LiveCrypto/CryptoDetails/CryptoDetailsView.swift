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
                            }
                            Text(details?.name ?? "")
                                .font(.largeTitle)
                        }
                        
                        if historycal != nil {
                            
                            Divider()
                            
                            Picker("Chart Type", selection: $chartType.animation(.easeInOut)) {
                                Text("Bar").tag(PricesChartType.bar)
                                Text("Line").tag(PricesChartType.line)
                              }
                              .pickerStyle(.segmented)
                            
                            BarChartView(data: historycal ?? [])
                            
                            LineChartView(data: historycal ?? [])
                            
                        } else {
                            Text("Error")
                                .foregroundColor(Color.red)
                                .padding(.all)
                        }
                        
                        if details != nil {

                            Text("Description")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                                        
                            Text(details?.description.en.stringByStrippingHTML() ?? "")
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            
                            Divider()
                            
                            let website = details?.links.homepage.first ?? ""
                            
                            Link(website , destination: (URL(string: website) ?? URL(string: "www.mooney.it"))!)
                                .font(.body)
                        } else {
                            
                            Text("Error")
                                .foregroundColor(Color.red)
                                .padding(.all)
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
    
    var body: some View {
        
        Text("Coin Graph")
            .font(.title)
            .padding()
        Divider()
            Chart(data, id: \.timestamp) { chartInfo in
                
                LineMark(
                    x: .value("Day", chartInfo.id),
                    y: .value("Prices", chartInfo.close)
                ).foregroundStyle(Color.green)
                
            }.chartXAxisLabel("Days", alignment: .center)
                .chartYAxisLabel("Price")
                .chartXAxis {
                    AxisMarks(values: .automatic(minimumStride: 42)) { _ in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(
                            format: .dateTime.day()
                        )
                    }
                }
                .chartYAxis {
                    AxisMarks( preset: .automatic, position: .leading)
                }
                .frame(height: 300)
                .padding()
        }
}

struct BarChartView: View {
    
    let data: [CryptoHistorycalResponse]
    
    var body: some View {
        
        Chart(data, id: \.timestamp) { chartInfo in
            
            BarMark(
                x: .value("Day", chartInfo.id),
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
        }.frame(height: 300)
            .padding()
            .chartXAxis {
                AxisMarks(values: .automatic(minimumStride: 42)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(
                        format: .dateTime.hour()
                    )
                }
            }
            .chartYAxisLabel("€")
            .chartForegroundStyleScale([
                CryptoHistorycalPriceTypes.close.rawValue: Color.black,
                CryptoHistorycalPriceTypes.low.rawValue: Color.red,
                CryptoHistorycalPriceTypes.high.rawValue: Color.green
            ])
    }
}


#Preview {
    CryptoDetailsView(cryptoId: "bitcoin")
}
