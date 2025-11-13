//
//  SpaceXDetailViewController.swift
//  SpaceXInsights
//
//  Created by luisr on 30/05/25.
//

import Foundation
import UIKit
import YouTubeiOSPlayerHelper

protocol SpaceXDetailViewControllerDelegate: AnyObject {
    func didTapYouTube(videoID: String)
    func didTapArticle(link: String)
}

final class SpaceXDetailViewController: UIViewController {
    
    weak var delegate: SpaceXDetailViewControllerDelegate?
    private let model: DTODetails
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let labelsStack = UIStackView()
    private let labelNoImages = UILabel()
    private let descriptionLabel = UILabel()
    private let playImageView1 = UIImageView()
    private let actionButton1 = UIButton(type: .system)
    private let playImageView2 = UIImageView()
    private let actionButton2 = UIButton(type: .system)
    private var collectionView: UICollectionView?
    private let pageControl = UIPageControl()
    private let playerView = YTPlayerView()
    
    var onPlayYouTube: ((String) -> Void)?
    var onOpenArticle: ((String) -> Void)?
    var strings = Strings()
    
    init(model: DTODetails) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = model.launchSiteName
        
        setupScrollView()
        setupLabels()
        setupCollectionViewIfNeeded()
        setupActionRows()
        setupPlayerView()
        setupConstraints()
        
    }
    
    private func configureUI() {
        
        titleLabel.text = strings.details_title
        descriptionLabel.text = model.launchSiteText
        
        if !model.flickrImages.isEmpty {
            pageControl.numberOfPages = model.flickrImages.count
            pageControl.currentPage = 0
            pageControl.pageIndicatorTintColor = .lightGray
            pageControl.currentPageIndicatorTintColor = .black
        }
        
        actionButton1.setTitle(strings.yt_video_button, for: .normal)
        actionButton1.backgroundColor = .red
        playImageView1.tintColor = .white
        
        actionButton2.setTitle(strings.launch_info_button, for: .normal)
        actionButton2.backgroundColor = .black
        playImageView2.tintColor = .white
        
    }
    
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupLabels() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        labelNoImages.text = strings.labelNoImages
        labelNoImages.textColor = .darkGray
        labelNoImages.textAlignment = .center
        labelNoImages.numberOfLines = 0
        labelNoImages.isHidden = true
        labelNoImages.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        labelsStack.axis = .vertical
        labelsStack.spacing = 8
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelsStack)
        contentView.addSubview(labelNoImages)
        contentView.addSubview(descriptionLabel)
        
        let labelTexts = [
            "\(strings.flightNumberText) \(model.flightNumber)",
            "\(strings.dateText) \(model.launchSiteName)",
            "\(strings.launchSiteText) \(model.launchSiteText)",
            "\(strings.rocketNameText) \(model.rocketName)",
            "\(strings.rocketTypeText) \(model.rocketType)"
        ]

        labelTexts.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 18)
            label.numberOfLines = 0
            labelsStack.addArrangedSubview(label)
        }
        
        descriptionLabel.text = model.launchSiteText ?? strings.no_additional_info
        titleLabel.text = model.launchSiteName
    }
    
    private func setupCollectionViewIfNeeded() {
        guard !model.flickrImages.isEmpty else {
            labelNoImages.isHidden = false
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 120)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        
        self.collectionView = collectionView
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        
        pageControl.numberOfPages = model.flickrImages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupActionRows() {
        [playImageView1, playImageView2].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.image = UIImage(systemName: "play.circle.fill")
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
        }
        
        playImageView1.backgroundColor = .red
        playImageView2.backgroundColor = .black
        
        actionButton1.translatesAutoresizingMaskIntoConstraints = false
        actionButton2.translatesAutoresizingMaskIntoConstraints = false
        
        [actionButton1, actionButton2].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 12
            $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        }
        
        contentView.addSubview(playImageView1)
        contentView.addSubview(actionButton1)
        contentView.addSubview(playImageView2)
        contentView.addSubview(actionButton2)
    }
    
    private func setupPlayerView() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.isHidden = true
        contentView.addSubview(playerView)
    }
    
    private func setupActions() {
        actionButton1.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        actionButton2.addTarget(self, action: #selector(openLaunchInfo), for: .touchUpInside)
    }
    
    @objc private func playVideo() {
        let videoID = model.youtubeID.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !videoID.isEmpty else {
            showAlert(message: strings.invalidVideoID)
            return
        }
        
        delegate?.didTapYouTube(videoID: videoID)
    }

    @objc private func openLaunchInfo() {
        guard
            let urlString = model.articleLink?.trimmingCharacters(in: .whitespacesAndNewlines),
            !urlString.isEmpty,
            let url = URL(string: urlString)
        else {
            showAlert(message: strings.invalidLink)
            return
        }
        delegate?.didTapArticle(link: urlString)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            labelsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            labelsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        if let collectionView = collectionView {
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 24),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                collectionView.heightAnchor.constraint(equalToConstant: 120),
                
                pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
                pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
                descriptionLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 16),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
        } else {
            NSLayoutConstraint.activate([
                labelNoImages.topAnchor.constraint(equalTo: labelsStack.bottomAnchor, constant: 24),
                labelNoImages.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                labelNoImages.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                descriptionLabel.topAnchor.constraint(equalTo: labelNoImages.bottomAnchor, constant: 24),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ])
        }
        
        NSLayoutConstraint.activate([
            playImageView1.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            playImageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            playImageView1.widthAnchor.constraint(equalToConstant: 40),
            playImageView1.heightAnchor.constraint(equalToConstant: 40),
            
            actionButton1.centerYAnchor.constraint(equalTo: playImageView1.centerYAnchor),
            actionButton1.leadingAnchor.constraint(equalTo: playImageView1.trailingAnchor, constant: 12),
            actionButton1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            playImageView2.topAnchor.constraint(equalTo: playImageView1.bottomAnchor, constant: 24),
            playImageView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            playImageView2.widthAnchor.constraint(equalToConstant: 40),
            playImageView2.heightAnchor.constraint(equalToConstant: 40),
            
            actionButton2.centerYAnchor.constraint(equalTo: playImageView2.centerYAnchor),
            actionButton2.leadingAnchor.constraint(equalTo: playImageView2.trailingAnchor, constant: 12),
            actionButton2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            playerView.topAnchor.constraint(equalTo: actionButton2.bottomAnchor, constant: 40),
            playerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 200),
            playerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

extension SpaceXDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.flickrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let imageURLString = model.flickrImages[indexPath.item]
        cell.configure(with: imageURLString)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let pageWidth = layout.itemSize.width + layout.minimumLineSpacing
        let currentPage = Int((scrollView.contentOffset.x + (pageWidth / 2)) / pageWidth)
        pageControl.currentPage = min(max(0, currentPage), pageControl.numberOfPages - 1)
    }
}

