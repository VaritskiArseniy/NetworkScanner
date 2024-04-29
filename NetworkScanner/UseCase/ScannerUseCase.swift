//
//  ScannerUseCase.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 19.04.24.
//

import Foundation

protocol ScannerUseCase {
    func fetchScanners() -> [ScannerModel]
}

class ScannerUseCaseImplementation: ScannerUseCase {
    
    private var scanners = [ScannerModel]()
    
    private var infraredDetection: ScannerModel {
        .init(icon: R.image.infraredScannerIcon(), name: "Infrared Detection")
    }
    
    private var bluetoothDetection: ScannerModel {
        .init(icon: R.image.bluetoothDetectionIcon(), name: "Bluetooth Detection")
    }
    
    private var magneticDetection: ScannerModel {
        .init(icon: R.image.magneticDetectionIcon(), name: "Magnetic Detection")
    }
    
    private var antispyTips: ScannerModel {
        .init(icon: R.image.antispyTipsIcon(), name: "Antispy Tips")
    }
    
    func fetchScanners() -> [ScannerModel] {
        scanners = [
            infraredDetection,
            bluetoothDetection,
            magneticDetection,
            antispyTips
        ]
        return scanners
    }
}
