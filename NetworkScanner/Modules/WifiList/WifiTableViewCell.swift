//
//  WifiTableViewCell.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 23.04.24.
//

import UIKit

class WifiTableViewCell: UITableViewCell {
    
    private enum Constants {
        static var white = { R.color.cFEFFFF() }
        static var goNextImage = { R.image.goNextImage() }
        static var wifiGoodImage = { R.image.wifiGoodImage() }
        static var wifiBadImage = { R.image.wifiBadImage() }
        static var tableBackgroundColor = { R.color.c100D2C() }
        static var ipTextColor = { R.color.c525878() }
        static var greyColor = { R.color.c525878() }
    }
    
    private lazy var wifiImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Constants.wifiGoodImage()
        return imageView
    }()
    
    private lazy var wifiInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var wifiNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = Constants.white()
        return label
    }()
    
    private lazy var wifiIpLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = Constants.ipTextColor()
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = Constants.greyColor()
        return separator
    }()
    
    private lazy var openImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.goNextImage()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: DeviceModel) {
        wifiNameLabel.text = model.name
        wifiIpLabel.text = model.ipAddress
        wifiImageView.image =  model.signal ?  Constants.wifiGoodImage() : Constants.wifiBadImage()
    }
    
    private func setup() {
        backgroundColor = Constants.tableBackgroundColor()
        contentView.addSubviews([wifiImageView, wifiInfoStackView, openImage, separatorView])
        wifiInfoStackView.addArrangedSubviews([wifiNameLabel, wifiIpLabel])
        
        wifiImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(36)
        }
        
        wifiInfoStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(wifiImageView.snp.trailing).offset(14)
            $0.height.equalTo(40)
            $0.width.equalToSuperview().dividedBy(2)
        }
        
        openImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(16)
            $0.width.equalTo(9)
        }
        
        separatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.width.equalToSuperview()
        }
        
    }
}
