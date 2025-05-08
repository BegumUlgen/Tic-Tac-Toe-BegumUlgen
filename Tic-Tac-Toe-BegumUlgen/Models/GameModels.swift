//
//  GameModels.swift
//  Tic-Tac-Toe-BegumUlgen
//
//  Created by Trakya7 on 6.05.2025.
import UIKit

// GameType Enum'u
enum GameType: String, CaseIterable {
    case single = "Two Sharing Device"
    case bot = "Play Against Bot"
    
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
