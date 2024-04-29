//
//  DeviceInfoTableViewCell.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 1.05.24.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    private enum Constants {
        static var white = { R.color.cFEFFFF() }
        static var tableBackgroundColor = { R.color.c100D2C() }
        static var greyColor = { R.color.c525878() }
    }
    
    private lazy var parameterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = Constants.white()
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = Constants.greyColor()
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = Constants.greyColor()
        return separator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with value: String, title: String) {
        parameterLabel.text = title
        valueLabel.text = value
    }
    
    private func setup() {
        backgroundColor = Constants.tableBackgroundColor()
        
        addSubviews([parameterLabel, valueLabel, separatorView])
        
        parameterLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        valueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(22)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        separatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.width.equalToSuperview()
        }
    }
}
