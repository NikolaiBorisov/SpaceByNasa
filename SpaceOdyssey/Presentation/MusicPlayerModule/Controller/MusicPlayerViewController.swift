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
    func nextTrack(nextButtonCount: Int)
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
    
    init(coordinator: MainCoordinator) {
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
            self.viewModel.mainView.stopButton.tintColor = .cyan
            self.viewModel.mainView.pauseButton.tintColor = .cyan
            self.delegate?.play()
        }
        
        viewModel.mainView.pauseButtonWasTapped = { [weak self] isPauseTapped in
            guard let self = self else { return }
            if isPauseTapped {
                self.viewModel.mainView.pauseButton.tintColor = .white
            }
            self.delegate?.pause()
        }
        
        viewModel.mainView.stopButtonWasTapped = { [weak self] isStopTapped in
            guard let self = self else { return }
            if isStopTapped {
                self.viewModel.mainView.stopButton.tintColor = .white
            }
            self.delegate?.stop()
        }
        
        viewModel.mainView.nextButtonWasTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.isFirstLoaded = false
            self.viewModel.nextButtonCount += 1
            self.viewModel.mainView.musicTableView.reloadData()
            if self.viewModel.nextButtonCount == 0 {
                self.delegate?.nextTrack(nextButtonCount: self.viewModel.nextButtonCount)
                self.viewModel.mainView.nowIsPlayingLabel.text = StringURL.interstellar1?.lastPathComponent
            } else if self.viewModel.nextButtonCount == 1 {
                self.delegate?.nextTrack(nextButtonCount: self.viewModel.nextButtonCount)
                self.viewModel.mainView.nowIsPlayingLabel.text = StringURL.interstellar2?.lastPathComponent
            } else if self.viewModel.nextButtonCount == 2 {
                self.delegate?.nextTrack(nextButtonCount: self.viewModel.nextButtonCount)
                self.viewModel.mainView.nowIsPlayingLabel.text = StringURL.interstellar3?.lastPathComponent
                self.viewModel.nextButtonCount = -1
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
        if viewModel.isFirstLoaded {
            cell.animateCell(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicPlayerCell = tableView.dequeueCell(for: indexPath)
        let item = viewModel.tracks[indexPath.row]
        cell.configureCell(with: item)
        if cell.trackTitleLabel.text == viewModel.mainView.nowIsPlayingLabel.text {
            cell.trackTitleLabel.textColor = .cyan
            cell.trackAuthorLabel.textColor = .cyan
            cell.setupEqualiser()
        } else {
            cell.trackTitleLabel.textColor = .lightGray
            cell.trackAuthorLabel.textColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppHeader.musicPlayerHeader, color: .white)
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
        let item = viewModel.tracks[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? MusicPlayerCell else { return }
        guard let image = cell.trackIcon.image,
        let author = cell.trackAuthorLabel.text,
        let title = cell.trackTitleLabel.text,
        let duration = cell.trackDurationLabel.text,
        let scene = item.scene else { return }
        let vc = TrackInfoViewController(coordinator: coordinator)
        vc.viewModel.icon = image
        vc.viewModel.author = author
        vc.viewModel.title = title
        vc.viewModel.duration = duration
        vc.viewModel.scene = scene
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
