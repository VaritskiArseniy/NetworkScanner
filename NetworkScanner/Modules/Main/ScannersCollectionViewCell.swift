//
//  ScanersCollectionViewCell.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 19.04.24.
//

import UIKit

private enum Constants {
    static var backgroundColor: UIColor? { R.color.c23175F() }
    static var white: UIColor? { R.color.cFEFFFF() }
}

class ScannersCollectionViewCell: UICollectionViewCell {
    
    private let scannerIcon = UIImageView()
    
    private lazy var scannerName: UITextView = {
       let textView = UITextView()
        textView.textColor = Constants.white
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = Constants.backgroundColor
        textView.font = .boldSystemFont(ofSize: 17)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([
            scannerIcon,
            scannerName
        ])
    }
    
    private func setupConstraints() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = 8
        scannerIcon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-22)
            $0.height.equalTo(44)
        }
        
        scannerName.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scannerIcon.snp.bottom)
            $0.width.equalTo(90)
            $0.height.equalTo(60)
            
        }
    }
    
    func configure(with model: ScannerModel) {
        scannerIcon.image = model.icon
        scannerName.text = model.name
    }
    
}
