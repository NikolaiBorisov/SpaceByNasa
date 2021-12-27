//
//  MusicPlayerViewController.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import UIKit
import MediaPlayer

protocol MusicPlayerViewControllerDelegate: AnyObject {
    func stop()
    func nextTrack(isNextButtonTapped: Bool)
    func play()
    func pause()
}

/// Class displays the music player
final class MusicPlayerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var delegate: MusicPlayerViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var viewModel = MusicViewModel()
    private let coordinator: MainCoordinator
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCallbacks()
        setupNavBar()
        viewModel.mainView.configureNowIsPlayingLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.mainView.showView(view: [
            viewModel.mainView.nowIsPlayingLabel,
            viewModel.mainView.buttonStackView
        ])
    }
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator
    ) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private Methods
    
    private func setupNavBar() {
        setupNavBarWith(
            title: Localization.musicVCTitle,
            font: .avenirNextDemiBoldOfSize(35)
        )
    }
    
    private func setupCallbacks() {
        viewModel.mainView.playButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.play()
        }
        
        viewModel.mainView.pauseButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.pause()
        }
        
        viewModel.mainView.stopButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.delegate?.stop()
        }
        
        viewModel.mainView.nextButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.isNextButtonPressed.toggle()
            if self.viewModel.isNextButtonPressed {
                self.delegate?.nextTrack(isNextButtonTapped: self.viewModel.isNextButtonPressed)
                self.viewModel.mainView.nowIsPlayingLabel.text = StringURL.zemlyane?.lastPathComponent
            } else if !self.viewModel.isNextButtonPressed {
                self.delegate?.nextTrack(isNextButtonTapped: self.viewModel.isNextButtonPressed)
                self.viewModel.mainView.nowIsPlayingLabel.text = StringURL.interstellar1?.lastPathComponent
            }
        }
    }
    
    private func setupView() {
        viewModel.mainView.musicTableView.delegate = self
        viewModel.mainView.musicTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension MusicPlayerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tracks.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MusicPlayerCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicPlayerCell = tableView.dequeueCell(for: indexPath)
        let item = viewModel.tracks[indexPath.row]
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppHeader.musicPlayerHeader)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension MusicPlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.mainView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? MusicPlayerCell else { return }
        switch indexPath.row {
        case 0:
            print("Test1!")
        case 1:
            print("Test2!")
        default:
            return
        }
    }
    
}
