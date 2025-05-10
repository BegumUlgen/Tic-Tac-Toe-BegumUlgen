//
//  BotViewController.swift
//  Tic-Tac-Toe-BegumUlgen
//
//  Created by Trakya7 on 10.05.2025.
//

import UIKit

class BotViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!  // Oyuncunun adını gösterecek label
    var playerName: String?  // Oyuncunun adı

    override func viewDidLoad() {
        super.viewDidLoad()

        // Eğer playerName var ise, label'a yazıyoruz
        if let name = playerName {
            playerNameLabel.text = name  // Label'a oyuncu ismini yerleştiriyoruz
        } else {
            playerNameLabel.text = "Player: Unknown"  // Eğer name yoksa, default bir mesaj koyuyoruz
        }
    }
}
