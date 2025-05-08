//
//  GameViewController.swift
//  Tic-Tac-Toe-BegumUlgen
//
//  Created by Trakya7 on 7.05.2025.
//

import UIKit

class GamesViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!


    // Gelen veriler
    var playerName: String?
    var opponentName: String?
    var selectedGameType: ViewController.GameType?

    override func viewDidLoad() {
        super.viewDidLoad()
           
           if player1Button == nil || player2Button == nil {
               print("Button bağlantısı yapılmamış!")
           }

           // Butonlara gelen isimleri yaz
           player1Button.setTitle(playerName ?? "Player 1", for: .normal)
           player2Button.setTitle(opponentName ?? "Player 2", for: .normal)
    }
}
