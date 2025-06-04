//
//  YouTubePlayerViewController.swift
//  SpaceXInsights
//
//  Created by luisr on 01/06/25.
//

import Foundation
import UIKit
import YouTubeiOSPlayerHelper

final class YouTubePlayerViewController: UIViewController {
    
    private let videoID: String
    private let playerView = YTPlayerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var strings: Strings?
    
    init(videoID: String) {
        self.videoID = videoID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActivityIndicator()
        loadVideo()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        title = strings?.youtubeVideoTitle
        navigationItem.largeTitleDisplayMode = .never
        
        if navigationController == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .close,
                target: self,
                action: #selector(close)
            )
        }
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.delegate = self
        view.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0 / 16.0)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: playerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: playerView.centerYAnchor),
        ])
    }
    
    private func loadVideo() {
        let trimmedID = videoID.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedID.isEmpty else {
            showAlert(message: strings?.youtubeVideoUnavailable ?? "")
            return
        }
        
        activityIndicator.startAnimating()
        playerView.load(withVideoId: trimmedID)
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}

extension YouTubePlayerViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        activityIndicator.stopAnimating()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        activityIndicator.stopAnimating()
        showAlert(message: strings?.youtubeVideoUnavailable ?? "")
    }
}
