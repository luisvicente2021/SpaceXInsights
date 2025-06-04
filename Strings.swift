//
//  Strings.swift
//  SpaceXInsights
//
//  Created by luisr on 03/06/25.
//

import Foundation

struct Strings {
    
    // MARK: - Login
    let emailPlaceholder = NSLocalizedString("login_email_placeholder", comment: "Placeholder for email input")
    let passwordPlaceholder = NSLocalizedString("login_password_placeholder", comment: "Placeholder for password input")
    let loginButtonTitle = NSLocalizedString("login_button_title", comment: "Title for the login button")
    let emptyFieldsError = NSLocalizedString("auth_error_empty_fields", comment: "Error shown when email or password is empty")
    
    // MARK: - Service Errors
    let badURL = NSLocalizedString("service_error_bad_url", comment: "")
    let decodingError = NSLocalizedString("service_error_decoding", comment: "")
    let emptyResponse = NSLocalizedString("service_error_empty_response", comment: "")
    
    func clientError(_ code: Int) -> String {
        return "Error del cliente (\(code)). Por favor revisa tu solicitud."
    }

    func serverError(_ code: Int) -> String {
        return "Error del servidor (\(code)). Intenta de nuevo más tarde."
    }
    
    func unknownError(_ code: Int) -> String {
        return String(format: NSLocalizedString("service_error_unknown", comment: ""), code)
    }
    
    func networkError(_ description: String) -> String {
        return String(format: NSLocalizedString("service_error_network", comment: ""), description)
    }
    
    // MARK: - Realm Repository Errors
    func saveError(_ description: String) -> String {
        return String(format: NSLocalizedString("realm_save_error", comment: ""), description)
    }
    
    func fetchError(_ description: String) -> String {
        return String(format: NSLocalizedString("realm_fetch_error", comment: ""), description)
    }
    
    // MARK: - ViewModel
    let dataError = NSLocalizedString("generic_data_error", comment: "Generic error for data fetch")
    
    // MARK: - SpaceX List View Controller
    let launchesPastTitle = NSLocalizedString("launches_past_title", comment: "Title for the launches past section")
    let navTitle = NSLocalizedString("spacex_nav_title", comment: "Navigation bar title for SpaceX")
    let errorAlertTitle = NSLocalizedString("error_alert_title", comment: "Alert title for errors")
    let errorAlertButtonOk = NSLocalizedString("error_alert_button_ok", comment: "OK button title for alerts")
    let year_title = NSLocalizedString("year_title", comment: "title")
    let flight_number = NSLocalizedString("flight_number", comment: "flight_number")
    
    // MARK: - SpaceX Detail View Controller
    let details_title = NSLocalizedString("details_title", comment: "Detail view title")
    let no_additional_info = NSLocalizedString("no_additional_info", comment: "No additional info message")
    let labelNoImages = NSLocalizedString("no_images_available", comment: "No images available message")
    let yt_video_button = NSLocalizedString("yt_video_button", comment: "YouTube video button title")
    let launch_info_button = NSLocalizedString("launch_info_button", comment: "Launch info button title")
    
    let flightNumberText = NSLocalizedString("flight_number_label", comment: "Flight number label")
    let launchSiteText = NSLocalizedString("launch_site_label", comment: "Launch site label")
    let rocketNameText = NSLocalizedString("rocket_name_label", comment: "Rocket name label")
    let rocketTypeText = NSLocalizedString("rocket_type_label", comment: "Rocket type label")
    let dateText = NSLocalizedString("date_label", comment: "Date")
    
    let invalidVideoID = NSLocalizedString("invalid_video_id", comment: "Alert message for invalid video ID")
    let invalidLink = NSLocalizedString("invalid_link", comment: "Alert message for invalid link")
    
    // MARK: - WebView Controller
    let invalidURLMessage = NSLocalizedString("invalid_url_message", comment: "Invalid URL message")
    let webContentTitle = NSLocalizedString("web_content_title", comment: "Title for web content")
    let navigationFailed = NSLocalizedString("navigation_failed", comment: "Message for navigation failure")
    let provisionalNavigationFailed = NSLocalizedString("provisional_navigation_failed", comment: "Message for provisional navigation failure")
    
    // MARK: - YouTube Player View Controller
    let youtubeVideoTitle = NSLocalizedString("youtube_video_title", comment: "Title for YouTube video view")
    let youtubeVideoUnavailable = NSLocalizedString("youtube_video_unavailable", comment: "Message when YouTube video is not available")
}
