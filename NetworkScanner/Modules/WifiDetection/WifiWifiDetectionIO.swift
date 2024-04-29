//
//  WifiIO.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 20.04.24.
//

import Foundation


protocol WifiDetectionOutput: AnyObject {
    func showWifiList()
    func showMain()
}

protocol WifiDetectionInput: AnyObject {
    
}
