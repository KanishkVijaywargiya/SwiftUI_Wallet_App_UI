//
//  WalletModel.swift
//  WalletAppUI
//
//  Created by Kanishk Vijaywargiya on 15/05/22.
//

import Foundation

// MARK: Sample card model & data
struct Card: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
}

var cards: [Card] = [
    Card(name: "Monica", cardNumber: "4345 5687 7867 0978", cardImage: "card1"),
    Card(name: "Jenna", cardNumber: "5687 4345 7867 5687", cardImage: "card2"),
    Card(name: "Jessica", cardNumber: "7867 4345 5687 7867", cardImage: "card3")
]
