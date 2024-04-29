//
//  WifiListViewModel.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 21.04.24.
//

import Foundation

protocol WifiListViewModelInterface {
    func showMain()
}

class WifiListViewModel {
    
    weak var view: WifiListViewControllerInterface?
    private weak var output: WifiListOutput?
    private let deviceUseCase: DeviceUseCase
    
    private var devices: [DeviceModel] {
        deviceUseCase.fetchDevices()
    }
        
    init(output: WifiListOutput, deviceUseCase: DeviceUseCase) {
        self.output = output
        self.deviceUseCase = deviceUseCase
    }
    
    func fetchDevices() -> [DeviceModel] {
        deviceUseCase.fetchDevices()
    }
}

extension WifiListViewModel: WifiListViewModelInterface {
    func showMain() {
        output?.showMain()
    }
}
