//
//  WifiListViewController.swift
//  NetworkScanner
//
//  Created by Арсений Варицкий on 21.04.24.
//

import UIKit

protocol WifiListViewControllerInterface: AnyObject { }

class WifiListViewController: UIViewController {
    
    private let viewModel: WifiListViewModel
    
    private enum Constants {
        static var backgroundColor = { R.color.c070615() }
        static var white = { R.color.cFEFFFF() }
        static var boltTextColor = { R.color.c6D59D3() }
        static var tableBackgroundColor = { R.color.c100D2C() }
        static var backButtonImage = { R.image.backButtonImage() }
        static var titleText = { "Result" }
        static var devicesText = { "Devices" }
        static var cellIdentifier = { "cellIdentifier" }
    }
    
    private lazy var backButton: UIButton = {
       let button = UIButton()
        button.setImage(Constants.backButtonImage(), for: .normal)
        button.addTarget(self, action: #selector(goMain), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Constants.backgroundColor()
        return scrollView
    }()
    
    private lazy var devicesCountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
   
    private lazy var devicesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = Constants.boltTextColor()
        label.textAlignment = .center
        label.text = String(viewModel.fetchDevices().count)
        return label
    }()
    
    private lazy var devicesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = Constants.white()
        label.textAlignment = .center
        label.text = Constants.devicesText()
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.rowHeight = 54
        tableView.register(
            WifiTableViewCell.self,
            forCellReuseIdentifier: Constants.cellIdentifier()
        )
        tableView.isScrollEnabled = false
        tableView.backgroundColor = Constants.tableBackgroundColor()
        tableView.layer.cornerRadius = 8
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: WifiListViewModel) {
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
        
        setupCustomBackButton()
    }
    
    private func setupUI() {
        setupNavigationBar()
        view.backgroundColor = Constants.backgroundColor()
        
        view.addSubview(scrollView)
        devicesCountStack.addArrangedSubviews([devicesCountLabel, devicesLabel])
        scrollView.addSubviews([devicesCountStack, tableView])
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.top.equalToSuperview()
        }
        
        devicesCountStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(32)
        }
        
        tableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(devicesCountStack.snp.bottom).offset(32)
            $0.width.equalTo(view.bounds.width - 40)
            $0.height.equalTo(calculateHeight())
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = Constants.titleText()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.backgroundColor()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.white()]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func calculateHeight() -> Int {
        let count = viewModel.fetchDevices().count
        let height = 54 * count
        return height
    }
    
    private func setupCustomBackButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc
    private func goMain() {
        viewModel.showMain()
    }
    
    private func showDetailViewController(for device: DeviceModel) {
        let deviceViewModel = DeviceViewModel()
        let detailViewController = DeviceViewController(viewModel: deviceViewModel, device: device)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private var selectedIndex: IndexPath = IndexPath(index: 0)
}

extension WifiListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexesToRedraw = [indexPath]
        selectedIndex = indexPath
        tableView.reloadRows(at: indexesToRedraw, with: .fade)
        
         let selectedDevice = viewModel.fetchDevices()[indexPath.row]
         showDetailViewController(for: selectedDevice)
     }
}

extension WifiListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchDevices().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier(), for: indexPath)
                as? WifiTableViewCell
        else { return UITableViewCell() }
        
        if selectedIndex == indexPath { cell.backgroundColor = Constants.tableBackgroundColor()}
        
        let device = viewModel.fetchDevices()[indexPath.row]
        cell.configure(with: device)
        return cell
    }
}

extension WifiListViewController: WifiListViewControllerInterface { }
