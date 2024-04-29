//
//  MainIO.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import Foundation

protocol MainOutput: AnyObject {
    func showMagnetic()
    func showWifiDetection()
}

protocol MainInput: AnyObject {
    
}
