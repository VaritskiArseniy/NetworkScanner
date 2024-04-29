//
//  MagneticViewController.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import UIKit

protocol MagneticViewControllerInterface: AnyObject {}

class MagneticViewController: UIViewController {

    private let viewModel: MagneticViewModel
    
    private enum Constants {
        static var backgroundColor = { R.color.c070615() }
        static var white = { R.color.cFEFFFF() }
        static var titleText = { "Magnetic Detection" }
        static var searchText = { "Search" }
        static var stopText = { "Stop" }
        static var magneticValueText = { "Search checking" }
        static var purpleTextColor = { R.color.c6D59D3() }
        static var backgroungImage = { R.image.magneticBackgroundImage() }
        static var scaleImage = { R.image.scaleImage() }
        static var arrowImage = { R.image.arrowImage() }
    }
    
    private var timeCounter = 0
    
    private var timer = Timer()
        
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.backgroungImage()
        return imageView
    }()
    
    private lazy var scaleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.scaleImage()
        return imageView
    }()
    
    private lazy var arrowImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Constants.arrowImage()
        return imageView
    }()
    
    private var arrowBackgroundView = UIView()
    
    
    private lazy var magneticValueLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.magneticValueText()
        label.textColor = Constants.white()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.purpleTextColor()
        button.setTitle(Constants.searchText(), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 26
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var backButton = BackButton()
    
    init(viewModel: MagneticViewModel) {
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
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = Constants.backgroundColor()
        
        arrowBackgroundView.addSubview(arrowImageView)
        
        view.addSubviews([backgroundImageView, searchButton, scaleImageView, arrowBackgroundView, magneticValueLabel])
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(backgroundImageView.snp.width).dividedBy(1.18)
        }
        
        scaleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(28)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(scaleImageView.snp.width).dividedBy(2)
        }
        
        arrowBackgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(scaleImageView.snp.bottom)
            $0.height.equalTo(scaleImageView.snp.height).dividedBy(5.6)
            $0.width.equalTo(scaleImageView.snp.width).dividedBy(1.73)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-34)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        
        magneticValueLabel.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(20)
            $0.top.equalTo(scaleImageView.snp.bottom).offset(47)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(36)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.title = Constants.titleText()
        
        let tapBackGesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonPressed))

        backButton.addGestureRecognizer(tapBackGesture)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.white()]
      
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
  
    @objc
    private func dismissButtonPressed() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc
    private func searchButtonPressed() {
        if searchButton.title(for: .normal) == Constants.stopText() {
            stopSearching()
        } else {
            startSearching()
        }
    }

    private func startSearching() {
        searchButton.setTitle(Constants.stopText(), for: .normal)
        startTimer()
    }

    private func stopSearching() {
        searchButton.setTitle(Constants.searchText(), for: .normal)
        timer.invalidate()
    }
    
    private func startTimer() {
        timeCounter = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc
    private func updateTime() {
        timeCounter += 1
        magneticValueLabel.text = "\(timeCounter)µT"
        
        if timeCounter >= 50 {
            timer.invalidate()
            searchButton.setTitle(Constants.searchText(), for: .normal)
        }
        
        animateArrow()
    }
    
    private func animateArrow() {
        let angle = CGFloat(timeCounter) / 50 * 90
        let rotationAngle = angle * .pi / 180
        self.arrowBackgroundView.transform = CGAffineTransform(rotationAngle: rotationAngle)
    }
}

extension MagneticViewController: MagneticViewControllerInterface {}
