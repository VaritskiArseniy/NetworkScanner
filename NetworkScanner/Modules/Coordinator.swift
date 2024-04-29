//
//  Coordinator.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import Foundation
import UIKit


final class Coordinator {
    
    private let assembly: Assembly
    private var navigationController = UINavigationController()
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
    
    func startMain(window: UIWindow) {
        let viewController = assembly.makeMain(output: self)
        navigationController = .init(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showMain() {
        navigationController.popToRootViewController(animated: false)
    }
}

extension Coordinator: MainOutput {
    func showMagnetic() {
        let magneticView = assembly.makeMagnetic(output: self)
        navigationController.pushViewController(magneticView, animated: true)
    }
    
    func showWifiDetection() {
        let wifiDetectionView = assembly.makeWifiDetection(output: self)
        navigationController.pushViewController(wifiDetectionView, animated: true)
    }
}

extension Coordinator: MagneticOutput {}

extension Coordinator: WifiDetectionOutput {
    func showWifiList() {
        let wifiListView = assembly.makeWifiList(output: self)
        navigationController.pushViewController(wifiListView, animated: true)
    }
}

extension Coordinator: WifiListOutput { }

extension Coordinator: DeviceOutput { }
