import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Enum
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

    // MARK: - IBOutlets
    @IBOutlet weak var gameTypePicker: UIPickerView!
    @IBOutlet weak var selectedGameTypeLabel: UILabel!
    
    @IBOutlet weak var yourNameTextField: UITextField!
    @IBOutlet weak var opponentNameTextField: UITextField!

    // MARK: - Properties
    private let gameTypes: [String] = ["Select Game Type"] + GameType.allCases.map { $0.rawValue }
    private var selectedGameType: GameType? = nil

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // PickerView ayarları
        gameTypePicker.delegate = self
        gameTypePicker.dataSource = self
        gameTypePicker.selectRow(0, inComponent: 0, animated: false)

        // Başlangıç metni
        selectedGameTypeLabel.text = "Please select a game type"

        // TextField'ları başlangıçta gizle
        yourNameTextField.isHidden = true
        opponentNameTextField.isHidden = true
    }

    // MARK: - PickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameTypes.count
    }

    // MARK: - PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Seçime göre textField'ları göster/gizle
        yourNameTextField.isHidden = true
        opponentNameTextField.isHidden = true
        
        // Seçilen oyun türünü güncelle
        if row == 0 {
            selectedGameType = nil
            selectedGameTypeLabel.text = "Please select a game type"
            opponentNameTextField.text = ""
        } else {
            selectedGameType = GameType.allCases[row - 1]
            selectedGameTypeLabel.text = selectedGameType?.description

            if selectedGameType == .bot {
                yourNameTextField.placeholder = "Enter your name"
                yourNameTextField.isHidden = false
                opponentNameTextField.text = ""  // opponent name'i boş yap
            } else if selectedGameType == .single {
                yourNameTextField.placeholder = "Player 1 name"
                opponentNameTextField.placeholder = "Player 2 name"
                yourNameTextField.isHidden = false
                opponentNameTextField.isHidden = false
                opponentNameTextField.text = ""  // opponent name'i boş yap
            }
        }
    }

    // MARK: - Start Game Butonuna Tıklandığında
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        if selectedGameType == .single || selectedGameType == .bot {
            performSegue(withIdentifier: "goToGameVC", sender: self)
        }
    }
    
   

    
    

    // MARK: - Segue için veri geçişi
    // MARK: - Segue için veri geçişi
    
    // MARK: - Segue için veri geçişi
    // MARK: - Segue için veri geçişi
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameVC" {
            if let gameVC = segue.destination as? GamesViewController {
                // Seçilen oyun türünü ve isimleri GameViewController'a gönderiyoruz
                gameVC.selectedGameType = selectedGameType
                gameVC.playerName = yourNameTextField.text
                gameVC.opponentName = opponentNameTextField.text            }
        }
    }
}
