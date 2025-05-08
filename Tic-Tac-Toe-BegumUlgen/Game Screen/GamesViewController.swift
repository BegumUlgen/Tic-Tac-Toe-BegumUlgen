//
//  GameViewController.swift
//  Tic-Tac-Toe-BegumUlgen
//
//  Created by Trakya7 on 7.05.2025.
//

import UIKit

class GamesViewController: UIViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    private let endGameButton = UIButton(type: .system)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Arka plan rengi
        view.backgroundColor = .white

        // Navigasyon başlığı
        self.title = "Xs and Os"

        // UI Bileşenlerini Ayarla
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        // Başlık Label
        titleLabel.text = "Game Screen"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // "End Game" Butonu
        endGameButton.setTitle("End Game", for: .normal)
        endGameButton.setTitleColor(.white, for: .normal)
        endGameButton.backgroundColor = .systemBlue
        endGameButton.layer.cornerRadius = 10
        endGameButton.translatesAutoresizingMaskIntoConstraints = false
        endGameButton.addTarget(self, action: #selector(endGameTapped), for: .touchUpInside)
        view.addSubview(endGameButton)

        // Auto Layout Kısıtlamaları
        NSLayoutConstraint.activate([
            // Başlık Label Yerleşimi
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            // End Game Buton Yerleşimi
            endGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endGameButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            endGameButton.widthAnchor.constraint(equalToConstant: 200),
            endGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Actions
    @objc private func endGameTapped() {
        print("Game Ended!") // Konsola yazı yazdır
        self.dismiss(animated: true, completion: nil) // Ekranı kapat
    }
}
