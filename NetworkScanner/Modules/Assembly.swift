//
//  Assembly.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import Foundation
import UIKit

final class Assembly {
    
    var scannerUseCase: ScannerUseCase {
        ScannerUseCaseImplementation()
    }
    
    var deviceUseCase: DeviceUseCase {
        DeviceUseCaseImplementation()
    }

    func makeMain(output: MainOutput) -> UIViewController {
        let viewModel = MainViewModel(output: output, scannerUseCase: scannerUseCase)
        let view = MainViewController(viewModel: viewModel)
        viewModel.view = view
        return view
    }
    
    func makeMagnetic(output: MagneticOutput) -> UIViewController {
        let viewModel = MagneticViewModel(output: output)
        let view = MagneticViewController(viewModel: viewModel)
        viewModel.view = view
        return view
    }
    
    func makeWifiDetection(output: WifiDetectionOutput) -> UIViewController {
        let viewModel = WifiDetectionViewModel(output: output)
        let view = WifiDetectionViewController(viewModel: viewModel)
        viewModel.view = view
        return view
    }
    
    func makeWifiList(output: WifiListOutput) -> UIViewController {
        let viewModel = WifiListViewModel(output: output, deviceUseCase: deviceUseCase)
        let view = WifiListViewController(viewModel: viewModel)
        viewModel.view = view
        return view
    }
}

