//
//  MagneticViewModel.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import Foundation

protocol MagneticViewModelInterface {
}

class MagneticViewModel {
    
    weak var view: MagneticViewControllerInterface?
    private weak var output: MagneticOutput?
    
    init(output: MagneticOutput) {
        self.output = output
    }
}

extension MagneticViewModel: MagneticViewModelInterface {

}
