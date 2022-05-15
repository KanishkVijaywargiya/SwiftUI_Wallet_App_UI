//
//  CardViewModel.swift
//  WalletAppUI
//
//  Created by Kanishk Vijaywargiya on 15/05/22.
//

import Foundation

class CardViewModel: ObservableObject {
    // retrieving index
    func getIndex(Card: Card) -> Int {
        return cards.firstIndex { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
    
    // MARK: Hiding all the digits of card number except last 4 digits.
    func customisedCardNumber(number: String) -> String {
        var newValue: String = ""
        let maxCount = number.count - 4
        number.enumerated().forEach { value in
            if value.offset >= maxCount {
                // displaying text
                let string = String(value.element)
                newValue.append(contentsOf: string)
            } else {
                // simply display stars
                // avoiding space
                let string = String(value.element)
                string == " " ?
                newValue.append(contentsOf: " ") :
                newValue.append(contentsOf: "*")
            }
        }
        return newValue
    }
}
