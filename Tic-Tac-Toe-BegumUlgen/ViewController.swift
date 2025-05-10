import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    enum GameType: String, CaseIterable {
        case single = "Two Sharing Device"
        case bot = "Play Against Bot"
        
        var description: String {
            switch self {
            case .single:
                return "Share your iPhone/iPad and play against a friend."
            case .bot:
                return "Play against this iPhone/iPad."
            }
        }
    }
    
    @IBOutlet weak var gameTypePicker: UIPickerView!
    @IBOutlet weak var selectedGameTypeLabel: UILabel!
    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var opponentNameTextField: UITextField!
    
    // Start Game butonları için IBOutlet'lar
    @IBOutlet weak var startGameForSinglePlayerButton: UIButton!
    @IBOutlet weak var startGameForBotButton: UIButton!
    
    private let gameTypes: [String] = ["Select Game Type"] + GameType.allCases.map { $0.rawValue }
    private var selectedGameType: GameType? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        gameTypePicker.delegate = self
        gameTypePicker.dataSource = self
        gameTypePicker.selectRow(0, inComponent: 0, animated: false)

        selectedGameTypeLabel.text = "Please select a game type"

        yourNameTextField.isHidden = true
        opponentNameTextField.isHidden = true
        
        // Başlangıçta her iki Start Game butonunu gizleyelim
        startGameForSinglePlayerButton.isHidden = true
        startGameForBotButton.isHidden = true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yourNameTextField.isHidden = true
        opponentNameTextField.isHidden = true
        
        if row == 0 {
            selectedGameType = nil
            selectedGameTypeLabel.text = "Please select a game type"
            yourNameTextField.text = ""
            opponentNameTextField.text = ""
        } else {
            selectedGameType = GameType.allCases[row - 1]
            selectedGameTypeLabel.text = selectedGameType?.description

            if selectedGameType == .bot {
                // Bot için "Start Game" butonunu göster
                startGameForBotButton.isHidden = false
                startGameForSinglePlayerButton.isHidden = true
                yourNameTextField.placeholder = "Enter your name"
                yourNameTextField.isHidden = false
                opponentNameTextField.isHidden = true
                yourNameTextField.text = ""
                opponentNameTextField.text = ""
            } else if selectedGameType == .single {
                // Çift oyuncu için "Start Game" butonunu göster
                startGameForSinglePlayerButton.isHidden = false
                startGameForBotButton.isHidden = true
                yourNameTextField.placeholder = "Player 1 name"
                opponentNameTextField.placeholder = "Player 2 name"
                yourNameTextField.isHidden = false
                opponentNameTextField.isHidden = false
                yourNameTextField.text = ""
                opponentNameTextField.text = ""
            }
        }
    }

    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        guard let gameType = selectedGameType else {
            showAlert(message: "Please select a game type.")
            return
        }

        switch gameType {
        case .single:
            if yourNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true ||
                opponentNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                showAlert(message: "Please enter both player names.")
                return
            }
        case .bot:
            if yourNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                showAlert(message: "Please enter your name.")
                return
            }
        }

        if gameType == .single {
            performSegue(withIdentifier: "goToGameVC", sender: self)
        } else if gameType == .bot {
            performSegue(withIdentifier: "goToBotVC", sender: self)
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // Segue veri geçişi
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameVC" {
            if let gameVC = segue.destination as? GamesViewController {
                gameVC.selectedGameType = selectedGameType
                gameVC.playerName = yourNameTextField.text
                gameVC.opponentName = opponentNameTextField.text
            }
        } else if segue.identifier == "goToBotVC" {
            if let botVC = segue.destination as? BotViewController {
                botVC.playerName = yourNameTextField.text
            }
        }
    }
}
