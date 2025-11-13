//
//  Coordinator.swift
//  SpaceXInsights
//
//  Created by luisr on 02/06/25.
//


import Foundation
import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let strings = Strings()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let repository: LoginRepository = LoginUserRepository()
        let useCase: LoginUserUseCase = LoginUserUseCase(repository: repository)
        let loginViewModel = LoginViewModel(useCase: LoginUserUseCase(repository: LoginUserRepository()))
        
        loginViewModel.onLoginSuccess = { [weak self] in
            print("oka")
            
            Task { await self?.showMainApp() }
            
        }
        
        let loginView = LoginView(viewModel: loginViewModel)
        let hostingController = UIHostingController(rootView: loginView)
        navigationController.setViewControllers([hostingController], animated: false)
            }
    
    @MainActor
    func makeViewModel() -> DashboardViewModel {
        let repository: DashboardRepository = DashboardRepositoryImp()
        let useCase: FetchDashboardItemsUseCase = FetchDashboardItemsUseCase(repository: repository)
        return DashboardViewModel(fetchUseCase: useCase)
    }
    
    
    @MainActor func showMainApp() {
    
     let mainVC = SpaceXListViewController(viewModel: makeViewModel())
        mainVC.delegate = self
        mainVC.strings = strings
        navigationController.pushViewController(mainVC, animated: true)
    }
}

extension MainCoordinator: SpaceXListViewControllerDelegate {
    
    func didSelectMission(_ model: DTODetails) {
        let detailVC = SpaceXDetailViewController(model: model)
        detailVC.delegate = self
        navigationController.pushViewController(detailVC, animated: true)
    }
   
}


extension MainCoordinator: SpaceXDetailViewControllerDelegate {
    
    func didTapYouTube(videoID: String) {
        let ytVC = YouTubePlayerViewController(videoID: videoID)
        ytVC.strings = strings
        navigationController.pushViewController(ytVC, animated: true)
    }
    
    func didTapArticle(link: String) {
        let webVC = WebViewController(urlString: link)
        webVC.strings = strings
        navigationController.pushViewController(webVC, animated: true)
    }
}

