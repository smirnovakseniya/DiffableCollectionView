//
//  SceneDelegate.swift
//  KSDiffableCollection
//
//  Created by Ксения Смирнова on 15.04.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //MARK: - Variables
    
    var window: UIWindow?
    
    //MARK: - Functions
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene  = scene as? UIWindowScene else { return }
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        window.windowScene = scene
        window.rootViewController = UINavigationController(rootViewController: CollectionVC())
        self.window = window
        setupNavBarAppearance()
        window.makeKeyAndVisible()
    }
    
    func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.brown,
                                                .font: UIFont.systemFont(ofSize: 24)]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
}
