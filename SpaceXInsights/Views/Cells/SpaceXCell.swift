//
//  SpaceXCell.swift
//  SpaceXInsights
//
//  Created by luisr on 29/05/25.
//

import UIKit

final class SpaceXCell: UITableViewCell {
    static let identifier = "SpaceXCell"
    let rocket = "rocket"
    let strings = Strings()
    
    private enum Constants {
        static let containerPadding: CGFloat = 15
        static let containerCornerRadius: CGFloat = 8
        static let containerBorderWidth: CGFloat = 1
        static let iconSize: CGFloat = 80
        static let spacingBetweenIconAndLabels: CGFloat = 25
        static let spacingBetweenLabels: CGFloat = 8
        static let rightArrowSize: CGFloat = 16
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = Constants.containerBorderWidth
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = Constants.containerCornerRadius
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rocketLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(activityIndicator) // agregamos aquí
        containerView.addSubview(nameLabel)
        containerView.addSubview(yearLabel)
        containerView.addSubview(rocketLabel)
        containerView.addSubview(rightArrowImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.containerPadding / 2),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.containerPadding / 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.containerPadding),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.containerPadding / 2),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            
            activityIndicator.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.containerPadding / 2),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.spacingBetweenIconAndLabels),
            nameLabel.trailingAnchor.constraint(equalTo: rightArrowImageView.leadingAnchor, constant: -Constants.containerPadding / 2),
            
            yearLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.spacingBetweenLabels),
            yearLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            rocketLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: Constants.spacingBetweenLabels),
            rocketLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            rocketLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            rocketLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Constants.containerPadding / 2),
            
            rightArrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            rightArrowImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.containerPadding / 2),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: Constants.rightArrowSize),
            rightArrowImageView.heightAnchor.constraint(equalToConstant: Constants.rightArrowSize)
        ])
    }
    
    func configure(with model: SpaceXModel) {
        nameLabel.text = model.mission_name
        yearLabel.text = "\(strings.year_title) \(model.launch_year)"
        rocketLabel.text = "\(strings.flight_number) \(model.flight_number)"
        
        loadImage(from: model.links.missionPatchSmall)
    }
    
    private func loadImage(from urlString: String?) {
        iconImageView.image = nil
        activityIndicator.startAnimating()
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            activityIndicator.stopAnimating()
            iconImageView.image = UIImage(systemName: rocket)
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.iconImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.iconImageView.image = UIImage(systemName: self?.rocket ?? "rocket")
                }
            }
        }
    }
}
