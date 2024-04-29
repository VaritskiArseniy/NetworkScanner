//
//  WifiScanView.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import UIKit

protocol WifiScanViewDelegate: AnyObject {
    func scanWifiButtonPress()
}

class WifiScanView: UIView {
    
    weak var delegate: WifiScanViewDelegate?
    
    private enum Constants {
        static var backgroundColor = { R.color.c100D2C() }
        static var currentWifiText = { "Current Wi-Fi" }
        static var wifiNameText = { "WIFI-Name" }
        static var readinessText = { "Ready to Scan this network" }
        static var scanButtonText = { "Scan current network" }
        static var white = { R.color.cFEFFFF() }
        static var wifiNameColor = { R.color.c6D59D3() }
        static var readinessColor = { R.color.c525878() }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var currentWifiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = Constants.currentWifiText()
        label.textColor = Constants.white()
        return label
    }()
    
    private lazy var wifiNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = Constants.wifiNameText()
        label.textColor = Constants.wifiNameColor()
        return label
    }()
    
    private lazy var wifiNameSpacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var readinessLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = Constants.readinessText()
        label.textColor = Constants.readinessColor()
        return label
    }()
    
    private lazy var scanButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.wifiNameColor()
        button.setTitle(Constants.scanButtonText(), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(scanButtonPressed), for: .touchUpInside)
        return button
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
        backgroundColor = Constants.backgroundColor()
        layer.cornerRadius = 10
        
        stackView.addArrangedSubviews([
            currentWifiLabel, wifiNameLabel, wifiNameSpacerView, readinessLabel, scanButton
        ])
        
        addSubview(stackView)
    }
 
    private func setupConstraints() {
        
        scanButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        wifiNameSpacerView.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        
        readinessLabel.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.trailing.leading.equalToSuperview().inset(16)
         }
    }
    
    @objc private func scanButtonPressed() {
        delegate?.scanWifiButtonPress()
    }
}
