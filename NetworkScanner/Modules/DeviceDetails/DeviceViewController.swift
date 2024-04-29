//
//  DeviceViewController.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 25.04.24.
//

import UIKit

protocol DeviceViewControllerInterface: AnyObject { }

class DeviceViewController: UIViewController {
    
    private enum Constants {
        static var backgroundColor = { R.color.c070615() }
        static var white = { R.color.cFEFFFF() }
        static var tableBackgroundColor = { R.color.c100D2C() }
        static var backButtonImage = { R.image.backButtonImage() }
        static var titleText = { "Device Details" }
        static var goodBackgroundImage = { R.image.deviceGoodBackgroundImage() }
        static var badBackgroundImage = { R.image.deviceBadBackgroundImage() }
        static var purpleTextColor = { R.color.c6D59D3() }
        static var redTextColor = { R.color.cD92929() }
        static var cellIdentifier = { "cellIdentifier" }
        static var connectionType: String { "Connection Type" }
        static var ipAddress: String { "IP Address" }
        static var macAddress: String { "MAC Address" }
        static var hostname: String { "Hostname" }
    }
    
    private var device: DeviceModel?
    
    private let viewModel: DeviceViewModel
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.backButtonImage(), for: .normal)
        button.addTarget(self, action: #selector(goToWifiList), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.rowHeight = 48
        tableView.register(
            DeviceTableViewCell.self,
            forCellReuseIdentifier: Constants.cellIdentifier()
        )
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = Constants.tableBackgroundColor()
        tableView.layer.cornerRadius = 8
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private lazy var deviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = device?.name
        return label
    }()
    
    private lazy var ipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = Constants.white()
        label.text = device?.ipAddress
        return label
    }()
    
    init(viewModel: DeviceViewModel, device: DeviceModel) {
        self.viewModel = viewModel
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupCustomBackButton()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = Constants.backgroundColor()
        
        setupSignalIndicator()
        view.addSubviews([backgroundImageView, tableView])
    }
    
    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(backgroundImageView.snp.width).dividedBy(1.18)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom).inset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(calculateTableHeight())
        }
    }
    
    private func calculateTableHeight() -> Int {
        let row = 48
        let header = 90
        let height = row * setupDeviceInfoView(for: device).count + header
        return height
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = Constants.titleText()
    }
    
    private func setupCustomBackButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc
    private func goToWifiList() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupSignalIndicator() {
        switch device?.signal {
        case true:
            backgroundImageView.image = Constants.goodBackgroundImage()
            deviceNameLabel.textColor = Constants.purpleTextColor()
            
        case false:
            backgroundImageView.image = Constants.badBackgroundImage()
            deviceNameLabel.textColor = Constants.redTextColor()
            
        case .none:
            backgroundImageView.image = Constants.goodBackgroundImage()
            deviceNameLabel.textColor = Constants.purpleTextColor()
            
        case .some(_):
            backgroundImageView.image = Constants.goodBackgroundImage()
            deviceNameLabel.textColor = Constants.purpleTextColor()
        }
    }
    
    private func setupDeviceInfoView(for device: DeviceModel?) -> [String] {
        guard let device = device else {
            return []
        }
        
        let deviceInfo = [
            device.conection,
            device.ipAddress,
            device.macAddress,
            device.hostName
        ]
        
        return deviceInfo.compactMap { $0 }
    }
    
    private func setupPropertiesTitles() -> [String] {
        
        let titles = [
            Constants.connectionType,
            Constants.ipAddress,
            Constants.macAddress,
            Constants.hostname
        ]
        
        return titles
        
    }
}

extension DeviceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Constants.tableBackgroundColor()
        
        headerView.addSubviews([deviceNameLabel, ipLabel])
        deviceNameLabel.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        ipLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(deviceNameLabel.snp.bottom)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
}

extension DeviceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setupDeviceInfoView(for: device).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier(), for: indexPath)
                as? DeviceTableViewCell
        else { return UITableViewCell() }
        
        let deviceInfo = setupDeviceInfoView(for: device)[indexPath.row]
        let tableTitles = setupPropertiesTitles()[indexPath.row]
        cell.configure(with: deviceInfo, title: tableTitles)
        return cell
    }
}

extension DeviceViewController: DeviceViewControllerInterface {}
