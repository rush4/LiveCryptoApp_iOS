import SwiftUI
import Charts

struct CryptoDetailsView: View {
    // Observed object to hold the view model
    @ObservedObject var viewModel = CryptoDetailsViewModel()
    
    // State variable to track the selected chart type
    @State var chartType: PricesChartType = .line
    
    // Crypto ID for fetching details
    let cryptoId: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Switch statement to handle different states of crypto details intent
                switch viewModel.cryptoDetailsntent {
                case .loading:
                    // Show progress view when loading
                    ProgressView().onAppear(perform: {
                        viewModel.fetchDetails(cryptoId ?? "")
                    })
                case .fetchedCryptoDetails(let details, let historycal):
                    VStack {
                        // Header section displaying crypto image and name
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
                                SimpleErrorView()
                            }
                            Text(details?.name ?? "")
                                .font(.custom("HelveticaNeue-Bold", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                                .padding()
                        }
                        
                        // Chart type picker and chart view section
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
                            
                            // Chart section with dynamic chart type
                            Text("Last Week Price")
                                .font(.custom("HelveticaNeue-Bold", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                            Divider()
                            switch chartType {
                            case .bar:
                                BarChartView(data: historycal ?? [], minValue: minValue, maxValue: maxValue)
                            case .line:
                                LineChartView(data: historycal ?? [], minValue: minValue, maxValue: maxValue)
                            }
                        } else {
                            SimpleErrorView()
                        }
                        Divider()
                        
                        // Crypto history and website section
                        if details != nil {
                            Text("Crypto History")
                                .font(.custom("HelveticaNeue-Bold", size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color.purple)
                                .padding()
                            Text(details?.description.en.stringByStrippingHTML() ?? "")
                                .font(.custom("HelveticaNeue-Bold", size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(Color.indigo)
                                .multilineTextAlignment(.leading)
                            Divider()
                            let website = details?.links.homepage.first ?? ""
                            Text("See more at:")
                                .font(.footnote)
                                .foregroundColor(Color.purple)
                                .multilineTextAlignment(.leading)
                            Link(website , destination: (URL(string: website) ?? URL(string: "www.mooney.it"))!)
                                .font(.body)
                        } else {
                            SimpleErrorView()
                        }
                        Divider()
                    }
                    .padding(.all)
                }
            }
        }
    }
}

#Preview {
    // Preview of CryptoDetailsView with a sample crypto ID
    CryptoDetailsView(cryptoId: "bitcoin")
}
