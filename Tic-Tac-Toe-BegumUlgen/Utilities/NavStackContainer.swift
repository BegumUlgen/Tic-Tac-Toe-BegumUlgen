//
//  ViewModifiers.swift
//  Tic-Tac-Toe-BegumUlgen
//
//  Created by Trakya7 on 7.05.2025.
//

import UIKit

class NavStackContainer: UIViewController {

    // iOS sürümüne bağlı olarak NavigationController'ı ayarla
    override func viewDidLoad() {
        super.viewDidLoad()

        // iOS 16 ve üzeri
        if #available(iOS 16, *) {
            setupNavigationStack()
        } else {
            setupNavigationView()
        }
    }

    // iOS 16 ve üzeri: NavigationStack
    private func setupNavigationStack() {
        let navigationStackController = UINavigationController()
        navigationStackController.viewControllers = [self] // İlgili ViewController'ı ekle
        navigationStackController.navigationBar.prefersLargeTitles = true // Büyük başlıklar
        addChild(navigationStackController)
        view.addSubview(navigationStackController.view)
        navigationStackController.didMove(toParent: self)
    }

    // iOS 15 ve altı: NavigationView
    private func setupNavigationView() {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = true // Büyük başlıklar
        navigationController.navigationBar.isTranslucent = false // Arka plan şeffaflığını kapat
        view.addSubview(navigationController.view)
        addChild(navigationController)
        navigationController.didMove(toParent: self)
    }
}
