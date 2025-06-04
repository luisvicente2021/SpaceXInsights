//
//  WebViewController.swift
//  SpaceXInsights
//
//  Created by luisr on 01/06/25.
//

import Foundation
import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    private let urlString: String
    private var webView = WKWebView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var strings: Strings?
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
        loadWebsite()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func loadWebsite() {
        guard let url = URL(string: urlString) else {
            showAlert(message: strings?.invalidURLMessage ?? "")
            return
        }
        activityIndicator.startAnimating()
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()  
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showAlert(message:  strings?.navigationFailed ?? "")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showAlert(message: strings?.provisionalNavigationFailed ?? "")
    }
}
