//
//  EPICViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 10.12.2021.
//

import UIKit

/// Class displays EPIC info
final class EPICViewController: UIViewController, LoadableErrorAlertController, LoadableInfoAlertController {
    
    // MARK: - Public Properties
    
    public var viewModel = EPICViewModel()
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getDataHandler()
        callBackHandler()
        alertHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        title: String
    ) {
        self.coordinator = coordinator
        self.viewModel.navBarTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func getDataHandler() {
        viewModel.getData { [weak self] error in
            self?.showErrorAlertWith(title: "Oops!", message: error, completion: {
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    private func callBackHandler() {
        viewModel.setupCallback { [weak self] error in
            self?.showErrorAlertWith(title: "Oops!", message: error, completion: {
                self?.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    private func setupView() {
        viewModel.mainView.epicTableView.delegate = self
        viewModel.mainView.epicTableView.dataSource = self
    }
    
    private func setupNavBar() {
        title = viewModel.navBarTitle
        navigationItem.backButtonTitle = ""
    }
    
    private func alertHandler() {
        showInfoAlertWith(
            title: "Note",
            message: "Loading Earth's Photos Takes a Little Bit More Time.\nPlease be Patient, We Are Working on It\n🌎",
            completionOK: {}) {
                self.coordinator.popToRoot(animated: true)
            }
    }
    
}

// MARK: - UITableViewDataSource

extension EPICViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.epicData.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? EPICCell else { return }
        guard viewModel.isFirstLoaded else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accessoryImage = AccessoryViewFactory.generateAccessoryViewWith(color: .lightGray)
        let cell: EPICCell = tableView.dequeueCell(for: indexPath)
        switch indexPath.section {
        case 0:
            guard let item = viewModel.epicData1 else { return cell }
            cell.configureFirstSectionCell(with: item)
            return cell
        case 1:
            let item = viewModel.epicData[indexPath.row]
            cell.configureSecondSectionCell(with: item)
            cell.selectionStyle = .gray
            cell.accessoryView = accessoryImage
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        if section == 0 {
            let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppHeader.EPICHeader1)
            headerView.addSubview(headerLabel)
            return headerView
        } else {
            let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppHeader.EPICHeader2)
            headerView.addSubview(headerLabel)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 80
        }
    }
    
}

// MARK: - UITableViewDelegate

extension EPICViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            print("No action required")
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) as? EPICCell,
                  let image = cell.epicImageView.image else { return }
            
            let title = "Taken at: \(viewModel.epicData[indexPath.row].date.dropFirst(10))"
            let lat = viewModel.epicData[indexPath.row].centroidCoordinates.lat.reduceNumbers()
            let lon = viewModel.epicData[indexPath.row].centroidCoordinates.lon.reduceNumbers()
            coordinator.pushSingleImageScreenWith(
                title: title,
                image: image,
                url: "",
                isAPODVC: false,
                isEPICVC: true,
                isMarsRover: false,
                infoText: "Lat: \(lat)\nLon: \(lon)"
            )
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .cyan
    }
    
}
