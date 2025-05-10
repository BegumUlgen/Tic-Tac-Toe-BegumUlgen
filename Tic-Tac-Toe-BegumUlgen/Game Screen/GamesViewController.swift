//
//  GameViewController.swift
//  Tic-Tac-Toe-BegumUlgen
//
//  Created by Trakya7 on 7.05.2025.
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!

    var playerName: String?
    var opponentName: String?
    var selectedGameType: ViewController.GameType?
    var startingPlayer: String?

    var currentPlayer: String = "X"
    var gameBoard: [String] = Array(repeating: "", count: 9)

    override func viewDidLoad() {
        super.viewDidLoad()

        player1Button.setTitle(playerName ?? "Player 1", for: .normal)
        player2Button.setTitle(opponentName ?? "Player 2", for: .normal)

        resetPlayerButtons()

        let buttons = getAllGameButtons()
        for btn in buttons {
            btn.setTitle("", for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 80, weight: .bold)
            btn.layer.borderWidth = 2
            btn.layer.borderColor = UIColor.black.cgColor
            btn.layer.cornerRadius = 5
        }

        updateTurnIndicator()
    }

    @IBAction func player1ButtonTapped(_ sender: UIButton) {
        startingPlayer = playerName
        currentPlayer = "X"
        highlightSelectedButton(selected: player1Button, deselected: player2Button)
        updateTurnIndicator()
    }

    @IBAction func player2ButtonTapped(_ sender: UIButton) {
        startingPlayer = opponentName
        currentPlayer = "O"
        highlightSelectedButton(selected: player2Button, deselected: player1Button)
        updateTurnIndicator()
    }

    func highlightSelectedButton(selected: UIButton, deselected: UIButton) {
        selected.backgroundColor = UIColor.systemGreen
        selected.setTitleColor(.white, for: .normal)
        deselected.backgroundColor = UIColor.systemGray5
        deselected.setTitleColor(.black, for: .normal)
    }

    func updateTurnIndicator() {
        if currentPlayer == "X" {
            player1Button.backgroundColor = UIColor.systemGreen
            player2Button.backgroundColor = UIColor.systemGray5
        } else if currentPlayer == "O" {
            player2Button.backgroundColor = UIColor.systemGreen
            player1Button.backgroundColor = UIColor.systemGray5
        }
    }

    func resetPlayerButtons() {
        player1Button.backgroundColor = UIColor.systemGray5
        player2Button.backgroundColor = UIColor.systemGray5
        player1Button.setTitleColor(.black, for: .normal)
        player2Button.setTitleColor(.black, for: .normal)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let index = getButtonIndex(for: sender) else { return }

        if gameBoard[index] != "" {
            return
        }

        gameBoard[index] = currentPlayer
        sender.setTitle(currentPlayer, for: .normal)

        if checkWinner() {
            showWinnerAlert()
        } else if checkDraw() {
            showDrawAlert()
        } else {
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
            updateTurnIndicator()
        }
    }

    func getButtonIndex(for button: UIButton) -> Int? {
        let buttons = getAllGameButtons()
        return buttons.firstIndex(of: button)
    }

    func getAllGameButtons() -> [UIButton] {
        return [button1, button2, button3, button4, button5, button6, button7, button8, button9]
    }

    func checkWinner() -> Bool {
        let winPatterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]

        for pattern in winPatterns {
            let a = gameBoard[pattern[0]]
            let b = gameBoard[pattern[1]]
            let c = gameBoard[pattern[2]]
            if a != "" && a == b && b == c {
                return true
            }
        }
        return false
    }

    func checkDraw() -> Bool {
        return !gameBoard.contains("") && !checkWinner()
    }

    func showWinnerAlert() {
        let winnerSymbol = currentPlayer
        let winnerName = winnerSymbol == "X" ? (playerName ?? "Player 1") : (opponentName ?? "Player 2")
        
        let message = "\(winnerName) won! (Winner: \(winnerSymbol))"

        let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.resetGame()
        }))

        alert.addAction(UIAlertAction(title: "Return to Homepage", style: .default, handler: { _ in
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }))

        present(alert, animated: true, completion: nil)
    }

    func showDrawAlert() {
        let alert = UIAlertController(title: "Draw", message: "The game ended in a draw!", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.resetGame()
        }))

        alert.addAction(UIAlertAction(title: "Return to Homepage", style: .default, handler: { _ in
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }))

        present(alert, animated: true, completion: nil)
    }

    func resetGame() {
        gameBoard = Array(repeating: "", count: 9)
        currentPlayer = "X"
        for button in getAllGameButtons() {
            button.setTitle("", for: .normal)
        }
        updateTurnIndicator()
    }
}
