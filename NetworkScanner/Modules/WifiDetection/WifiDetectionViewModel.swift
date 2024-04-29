//
//  WifiViewModel.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 20.04.24.
//

import Foundation

protocol WifiDetectionViewModelInterface {
    func showWifiList()
    func showMain()
}

class WifiDetectionViewModel {
    
    weak var view: WifiDetectionViewControllerInterface?
    private weak var output: WifiDetectionOutput?
        
    init(output: WifiDetectionOutput) {
        self.output = output
    }
}

extension WifiDetectionViewModel: WifiDetectionViewModelInterface {
    func showMain() {
        output?.showMain()
    }
    
    func showWifiList() {
        output?.showWifiList()
    }
    
}
