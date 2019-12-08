//
//  AppDelegate.swift
//  RxArch
//
//  Created by Albert Gil Escura on 17-06-19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Public Properties

    var window: UIWindow?
    
    // MARK: Private Properties
    
    private let app = Application()
    
    // MARK: Init
    
    override init() {
        self.window = UIWindow()
    }
    
    // MARK: Public Methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        app.start(with: window!)
        
        return true
    }
}

