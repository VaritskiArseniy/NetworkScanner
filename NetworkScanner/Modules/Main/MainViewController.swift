//
//  MainViewController.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 18.04.24.
//

import UIKit
import SnapKit

protocol MainViewControllerInterface: AnyObject {
    func scanWifiButtonPress()
}

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private enum Constants {
        static var backgroundColor = {R.color.c070615() }
        static var settingsImage = { R.image.settingsImage() }
        static var backgroundImage = { R.image.mainBackgroundImage() }
        static var collectionCellIdentifier = { "collectionCellIdentifier" }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Constants.backgroundColor()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.settingsImage(), for: .normal)
        return button
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.backgroundImage()
        return imageView
    }()
    
    private let scannersCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let wifiScanView = WifiScanView()

    init(viewModel: MainViewModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        self.title = "Main"
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Constants.backgroundColor()
        setupCollectionView()
        view.addSubview(scrollView)
        scrollView.addSubviews([settingsButton, backgroundImage, wifiScanView, scannersCollection])
        wifiScanView.delegate = self
        }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        settingsButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        backgroundImage.snp.makeConstraints {
            $0.leading.trailing.centerX.equalToSuperview()
            $0.top.equalTo(settingsButton.bounds.minY - 50)
            $0.height.equalTo(backgroundImage.snp.width).dividedBy(1.18)
        }
        
        wifiScanView.snp.makeConstraints {
            $0.top.equalTo(backgroundImage.snp.bottom).inset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        scannersCollection.snp.makeConstraints {
            $0.top.equalTo(wifiScanView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(315)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        scannersCollection.collectionViewLayout = layout
        
        scannersCollection.backgroundColor = Constants.backgroundColor()
        
        scannersCollection.register(
            ScannersCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.collectionCellIdentifier()
        )
        scannersCollection.dataSource = self
        scannersCollection.delegate = self
        scannersCollection.showsHorizontalScrollIndicator = false
        scannersCollection.isScrollEnabled = false
    }
    
    @objc
    func scanWifiButtonPress() {
        viewModel.showWifiDetection()
    }
}

extension MainViewController: UICollectionViewDelegate { 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 2:
            viewModel.showMagnetic()
        default:
            return
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.fetchScanners().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.collectionCellIdentifier(),
            for: indexPath
        ) as? ScannersCollectionViewCell else {
            return UICollectionViewCell()
        }
        let scanner = viewModel.fetchScanners()[indexPath.item]
        cell.configure(with: scanner)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}

extension MainViewController: MainViewControllerInterface {}

extension MainViewController: WifiScanViewDelegate {}
