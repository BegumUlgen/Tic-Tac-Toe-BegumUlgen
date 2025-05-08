import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // GameType Enum'u
    enum GameType: String, CaseIterable {
        case single = "Two Sharing Device" // Aynı cihazda iki kişilik
        case bot = "Play Against Bot"      // Tek başına cihaza karşı
        
        // Açıklama metni
        var description: String {
            switch self {
            case .single:
                return "Share your iPhone/iPad and play against a friend."
            case .bot:
                return "Play against this iPhone/iPad."
            }
        }
    }
    
    // GameType seçenekleri
    private let gameTypes: [String] = ["Select Game Type"] + GameType.allCases.map { $0.rawValue }

    // IBOutlet'lar
    @IBOutlet weak var gameTypePicker: UIPickerView!
    
    @IBOutlet weak var selectedGameTypeLabel: UILabel!

    @IBOutlet weak var stackView: UIStackView!


    // TextField'lar
    private let yourNameTextField = UITextField()
    private let opponentNameTextField = UITextField()

    // Dinamik açıklama yazısı
    private let descriptionLabel = UILabel()

    // Start Game Butonu
    private let startGameButton = UIButton(type: .system)

    // Seçilen oyun türünü saklamak için değişken
    private var selectedGameType: GameType? = nil // İlk başta seçim yapılmadı
    private var yourName: String = ""
    private var opponentName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Picker View Ayarları
        gameTypePicker.delegate = self
        gameTypePicker.dataSource = self
        gameTypePicker.translatesAutoresizingMaskIntoConstraints = false

        // Varsayılan Label metnini ayarla
        selectedGameTypeLabel.text = "Selected Game Type: None"
        selectedGameTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        // Açıklama Label Ayarları
        descriptionLabel.text = "Please select a game type."
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        // Start Game Butonu Ayarları
        startGameButton.setTitle("Start Game", for: .normal)
        startGameButton.addTarget(self, action: #selector(startGameButtonTapped(_:)), for: .touchUpInside)
        startGameButton.configuration = .filled()
        startGameButton.configuration?.baseBackgroundColor = .systemBlue
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.isEnabled = false // İlk başta buton devre dışı

        // Stack View Ayarları
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // TextField Ayarları
        yourNameTextField.placeholder = "Your name"
        yourNameTextField.borderStyle = .roundedRect
        yourNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        opponentNameTextField.placeholder = "Opponent name"
        opponentNameTextField.borderStyle = .roundedRect
        opponentNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        // UI'yi Kur
        view.addSubview(gameTypePicker)
        view.addSubview(selectedGameTypeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        view.addSubview(startGameButton)

        setupLayout()
        updateUI(for: selectedGameType)
    }

    // MARK: - Layout Setup
    private func setupLayout() {
        // Picker'ı sayfanın üstüne hizala
        NSLayoutConstraint.activate([
            gameTypePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameTypePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameTypePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // Label Constraints
            selectedGameTypeLabel.topAnchor.constraint(equalTo: gameTypePicker.bottomAnchor, constant: 20),
            selectedGameTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Description Label Constraints
            descriptionLabel.topAnchor.constraint(equalTo: selectedGameTypeLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Stack View Constraints
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Start Game Button Constraints
            startGameButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.widthAnchor.constraint(equalToConstant: 200),
            startGameButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Tek sütun
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameTypes.count // Tüm seçenekler
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameTypes[row] // Satırdaki metni döndür
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Eğer "Select Game Type" seçiliyse
        if row == 0 {
            selectedGameType = nil
            descriptionLabel.text = "Please select a game type."
            selectedGameTypeLabel.text = "Selected Game Type: None"
            startGameButton.isEnabled = false
        } else {
            // Seçilen oyun türünü güncelle
            selectedGameType = GameType.allCases[row - 1] // İlk eleman başlık olduğu için
            if let selectedGameType = selectedGameType {
                selectedGameTypeLabel.text = "Selected Game Type: \(selectedGameType.rawValue)"
                descriptionLabel.text = selectedGameType.description
                startGameButton.isEnabled = true
            } else {
                selectedGameTypeLabel.text = "Selected Game Type: None"
                descriptionLabel.text = "Please select a game type."
                startGameButton.isEnabled = false
            }
        }

        // UI'yi güncelle
        updateUI(for: selectedGameType)
    }

    // MARK: - UI Güncelleme Fonksiyonu

    private func updateUI(for gameType: GameType?) {
        // Stack View'i temizle
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        guard let gameType = gameType else {
            return
        }

        switch gameType {
        case .single:
            stackView.addArrangedSubview(yourNameTextField)
            stackView.addArrangedSubview(opponentNameTextField)
        case .bot:
            stackView.addArrangedSubview(yourNameTextField)
        }
    }

    // TextField İçeriği Değiştiğinde
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == yourNameTextField {
            yourName = textField.text ?? ""
        } else if textField == opponentNameTextField {
            opponentName = textField.text ?? ""
        }
    }

    // Start Game Butonuna Basıldığında
    @objc private func startGameButtonTapped(_ sender: UIButton) {
        print("Game Started!")
        let gameVC = GamesViewController() // GameViewController'ı başlat
                gameVC.modalPresentationStyle = .fullScreen // Tam ekran olarak göster
                present(gameVC, animated: true, completion: nil) // Ekranı aç
            }
        }

        class GameViewController: UIViewController {
            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = .white
                let label = UILabel()
                label.text = "Game Screen"
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                label.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(label)

                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])        // Oyun başlatma işlemi burada yapılır
    }
}
