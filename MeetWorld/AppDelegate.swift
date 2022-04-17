//
//  AppDelegate.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import UIKit
import Swinject
import SwinjectStoryboard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // setting the Swinject container to the default SwinjectStoryboard container
    var container = SwinjectStoryboard.defaultContainer

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // registering the dependencies into the Swinject container
        self.registerDependencies()
        
        // presenting the window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        // instantiating the initial view controller, and assigning the default SwinjectStoryboard container to it
        let bundle = Bundle(for: UsersViewController.self)
        let swinjectStoryboard = SwinjectStoryboard.create(name: "Main", bundle: bundle, container: self.container)
        window.rootViewController = swinjectStoryboard.instantiateInitialViewController()
        
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

    // registering the dependencies into the Swinject container
    private func registerDependencies() {
        // registering UserManager
        self.container.register(UserManager.self, factory: { r in
            // registering the mock version, in case of running in the simulator
            #if targetEnvironment(simulator)
                return MockUserManager()
            // registering the actual implementation when not running in the simulator
            #else
                return ServerUserManager()
            #endif
        })
        
        // registering the ViewModels
        self.container.register(UsersViewModeling.self) { r in
            return UsersViewModel(userManager: r.resolve(UserManager.self)!)
        }
        
        self.container.register(MapViewModeling.self) { r in
            return MapViewModel(userManager: r.resolve(UserManager.self)!)
        }
        
        self.container.register(UpdateUserViewModeling.self) { r in
            return UpdateUserViewModel(userManager: r.resolve(UserManager.self)!)
        }
        
        // injecting the dependencies into the Views
        self.container.storyboardInitCompleted(UsersViewController.self) { r, c in
            c.viewModel = r.resolve(UsersViewModeling.self)!
        }
        
        self.container.storyboardInitCompleted(MapViewController.self) { r, c in
            c.viewModel = r.resolve(MapViewModeling.self)!
        }
        
        self.container.storyboardInitCompleted(UpdateUserViewController.self) { r, c in
            c.viewModel = r.resolve(UpdateUserViewModeling.self)!
        }
    }

}

