//
//  MainViewModel.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import Foundation


protocol MainViewModelInterface {
    func showMagnetic()
    func showWifiDetection()
    func fetchScanners() -> [ScannerModel]
}

class MainViewModel {
    
    weak var view: MainViewControllerInterface?
    private weak var output: MainOutput?
    
    private var scannerUseCase: ScannerUseCase
    
    init(output: MainOutput, scannerUseCase: ScannerUseCase) {
        self.output = output
        self.scannerUseCase = scannerUseCase
    }
    
    func fetchScanners() -> [ScannerModel]{
        return scannerUseCase.fetchScanners()
    }
}

extension MainViewModel: MainViewModelInterface {
    func showMagnetic() {
        output?.showMagnetic()
    }
    
    func showWifiDetection() {
        output?.showWifiDetection()
    }
    
    
}
