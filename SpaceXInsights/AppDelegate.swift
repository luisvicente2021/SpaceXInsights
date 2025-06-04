//
//  AppDelegate.swift
//  SpaceXInsights
//
//  Created by luisr on 29/05/25.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


import RealmSwift

func configureRealm() {
    let config = Realm.Configuration(
        schemaVersion: 1,  // Incrementa este número cuando hagas cambios en el modelo
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // Aquí puedes poner código para migrar datos si necesitas
                // Pero si solo agregaste propiedades opcionales, puedes dejar vacío
                print("Migración a schemaVersion 1 realizada")
            }
        }
    )
    
    Realm.Configuration.defaultConfiguration = config
    
    // Intenta abrir Realm para que aplique la migración
    do {
        _ = try Realm()
        print("Realm configurado y listo")
    } catch {
        print("Error configurando Realm: \(error)")
    }
}
