//
//  UIView+Extension.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
