//
//  AppDelegate.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit
import RealmSwift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configurationRealm()
        UINavigationBar.appearance().tintColor = .white
        return true
    }
    
    // MARK: - Configuration For Realm
    private func configurationRealm() {
        let fileManager = FileManager.default
        var config = Realm.Configuration()
        let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        if let applicationSupportURL = urls.last {
            do {
                try fileManager.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
                config.fileURL = applicationSupportURL.appendingPathComponent("demo.realm")
            } catch let err {
                print(err.localizedDescription)
            }
        }
        config.deleteRealmIfMigrationNeeded = true
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
        print (Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
}

