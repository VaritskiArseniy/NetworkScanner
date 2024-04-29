//
//  DeviceViewModel.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 25.04.24.
//

import Foundation


protocol DeviceViewModelInterface {
}

class DeviceViewModel {
    
    private weak var outout: DeviceOutput?
    weak var view: DeviceViewControllerInterface?

    init(outout: DeviceOutput? = nil) {
        self.outout = outout
    }
    
}

extension DeviceViewModel: DeviceViewModelInterface {
   
}
