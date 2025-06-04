//
//  UIViewController+Alerts.swift
//  SpaceXInsights
//
//  Created by luisr on 03/06/25.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String = Strings().errorAlertTitle, message: String, buttonTitle: String = Strings().errorAlertButtonOk) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
