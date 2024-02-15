import SwiftUI

struct CryptoListView: View {
    @ObservedObject var viewModel: CryptoListViewModel // ObservedObject for view model
    
    var body: some View {
        
        let viewmodel = self.viewModel
        
        switch viewModel.listIntent {
        case .loading:
            // Show loading indicator when data is loading
            ProgressView().onAppear {
                Task{
                    await viewmodel.fetchTopCryptos()
                }
            }
        case .fetched(let cryptos):
            if cryptos.isEmpty {
                // Show message if no results found
                Text("No Results found")
                    .foregroundColor(Color.red)
                    .padding(.all)
            } else {
                // Show list of cryptos if available
                VStack(){
                    // Header text for the list
                    Text("Markets")
                        .font(.custom("HelveticaNeue-Bold", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                        .padding()
                    
                    // List of cryptos
                    List(cryptos, id: \.id) { crypto in
                        Button(action: {
                            viewmodel.cryptoSelected(crypto.id)
                        }) {
                            CryptoRowView(crypto: crypto)
                        }
                    }.refreshable {
                        await viewModel.fetchTopCryptos()
                    }
                }
            }
        case .apiError(let error):
            // Handle API errors
            if error.code == 429 {
                let secondsToRetry = error.userInfo["NSLocalizedDescription"] as? String ?? ""
                CustomErrorView(action: viewModel.fetchTopCryptos, secondsToRetry: secondsToRetry)
            }
        }
    }
}

#Preview {
    CryptoListView(viewModel: CryptoListViewModel())
}
