//
//  BackButtonView.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 2.05.24.
//

import UIKit

class BackButton: UIView {
    
    private enum Constants {
        static var purpleTextColor = { R.color.c6D59D3() }
        static var backButtonImage = { R.image.backButtonImage() }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.backButtonImage()
        return imageView
    }()
    
    private lazy var previousVCLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.purpleTextColor()
        label.font = .systemFont(ofSize: 17)
        label.text = "Main"
        return label
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
        layer.cornerRadius = 10
        
        stackView.addArrangedSubviews([
            backImageView, previousVCLabel
        ])
        
        addSubview(stackView)
    }
 
    private func setupConstraints() {
        
        stackView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
         }
    }
}
