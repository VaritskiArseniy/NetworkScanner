//
//  UIStackView+Extension.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 19.04.24.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
