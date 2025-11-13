//
//  ViewController.swift
//  SpaceXInsights
//
//  Created by luisr on 29/05/25.
//

import UIKit

protocol SpaceXListViewControllerDelegate: AnyObject {
    func didSelectMission(_ model: DTODetails)
}

class SpaceXListViewController: UIViewController {
    weak var delegate: SpaceXListViewControllerDelegate?
    
    private let tableView = UITableView()
    private var viewModel: DashboardViewModel
    private var items: [LaunchViewData] = []
    var onMissionSelected: ((LaunchViewData) -> Void)?
    var strings: Strings?
    
    init (viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) // ✅ llamas al init de UIViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationTitle()
        setupTableView()
        fetchData()
    }
    
    private func setupView() {
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        titleLabel.text = strings?.launchesPastTitle
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupNavigationTitle() {
        let rocketImageView = UIImageView(image: UIImage(named: "spaceship"))
        rocketImageView.tintColor = .label
        rocketImageView.contentMode = .scaleAspectFit
        rocketImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rocketImageView.widthAnchor.constraint(equalToConstant: 20),
            rocketImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let titleLabelNav = UILabel()
        titleLabelNav.text = strings?.navTitle
        titleLabelNav.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabelNav.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [rocketImageView, titleLabelNav])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        navigationItem.titleView = stackView
    }
    
    private func setupTableView() {
        tableView.register(SpaceXCell.self, forCellReuseIdentifier: SpaceXCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
    }
    
    private func fetchData() {
        Task {
                await viewModel.loadLaunches()
                await MainActor.run {
                    self.items = viewModel.launches
                    self.tableView.reloadData()
                }
            }
    }
}

extension SpaceXListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpaceXCell.identifier, for: indexPath) as? SpaceXCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: items[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = items[indexPath.row]
        
        let dtoDetails = DTODetails(
            flightNumber: "\(selected.id)",
            launchSiteText: selected.details,
            launchSiteName: selected.missionName,
            rocketName: selected.missionName,
            rocketType: selected.missionPatch ?? "missionpatch",
            flickrImages: [],
            youtubeID: "youtiube",
            articleLink: "articvle link")
        delegate?.didSelectMission(dtoDetails)
    }
}
