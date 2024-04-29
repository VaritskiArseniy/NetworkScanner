//
//  WifiViewController.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 20.04.24.
//

import UIKit
import Lottie

protocol WifiDetectionViewControllerInterface: AnyObject {}

class WifiDetectionViewController: UIViewController {
    
    private let viewModel: WifiDetectionViewModel
    
    private enum Constants {
        static var backgroundColor = { R.color.c070615() }
        static var white = { R.color.cFEFFFF() }
        static var boltTextColor = { R.color.c6D59D3() }
        static var titleWifiText = { "Scanning Your Wi-Fi" }
        static var wifiNameText = { "WIFI_Name" }
        static var stopText = { "Stop" }
    }
    
    private var timeCounter = 0
    
    private var timer = Timer()
    
    private var isCanceled = false
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleWifiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = Constants.titleWifiText()
        label.textColor = Constants.white()
        return label
    }()
    
    private lazy var wifiNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = Constants.wifiNameText()
        label.textColor = Constants.boltTextColor()
        return label
    }()
    
    private lazy var scaningAnimationView: LottieAnimationView = {
       var animation = LottieAnimationView()
        animation = .init(name: "scaningAnimation")
        return animation
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = "0s"
        label.textColor = Constants.white()
        return label
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.boltTextColor()
        button.setTitle(Constants.stopText(), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: WifiDetectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        isCanceled = true
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Constants.backgroundColor()
        stackView.addArrangedSubviews([titleWifiLabel, wifiNameLabel])
        view.addSubviews([stackView, scaningAnimationView, stopButton, timeLabel])
        scaningAnimationView.play()
        startTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            if let self = self, !self.isCanceled {
                self.navigateToWifiList()
                self.timer.invalidate()
            }
        }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.width.equalToSuperview()
            $0.height.equalTo(54)
        }
        
        scaningAnimationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalToSuperview().inset(20)
        }
        
        stopButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(36)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stopButton.frame.minY - 138)
            $0.height.width.equalTo(22)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc
    private func updateTime() {
        timeCounter += 1
        timeLabel.text = "\(timeCounter)s"
    }
    
    private func navigateToWifiList() {
        viewModel.showWifiList()
    }
    
    @objc
    private func stopButtonPressed() {
        viewModel.showMain()
    }
}

extension WifiDetectionViewController: WifiDetectionViewControllerInterface {}
