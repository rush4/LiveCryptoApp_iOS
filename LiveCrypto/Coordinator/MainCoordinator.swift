//
//  MainCoordinator.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 07/02/24.
//

import Foundation
import UIKit
import SwiftUI

public class MainCoordinator: NSObject {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // This method set the delegate of navigation controller and configure the Coordinator first view
    func start() {
        navigationController?.delegate = self
        configureFirstController()
    }
    
    private func configureFirstController() {
        let cryptoListViewModel = CryptoListViewModel()
        let contentView = CryptoListView(viewModel: cryptoListViewModel)
        
        let hostingViewController = UIHostingController(rootView: contentView)
        cryptoListViewModel.goToCryptoDetailsClosure = { [weak self] cryptoId in
        guard let self = self else { return }
            self.goToListVc(cryptoId: cryptoId)
            cryptoListViewModel.listIntent = .loading
        }
        
        navigationController?.pushViewController(hostingViewController, animated: true)
    }
    
    func goToListVc(cryptoId: String){
        let viewModel = CryptoDetailsViewModel()
        let contentView = CryptoDetailsView(viewModel: viewModel, cryptoId: cryptoId)
        
        let hostingViewController = UIHostingController(rootView: contentView)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(hostingViewController, animated: true)
    }
}

// Delegate methods for UINavigationControllerDelegate
extension MainCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool){
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}



