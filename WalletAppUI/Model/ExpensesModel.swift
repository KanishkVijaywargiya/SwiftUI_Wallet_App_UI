//
//  ExpensesModel.swift
//  WalletAppUI
//
//  Created by Kanishk Vijaywargiya on 15/05/22.
//

import Foundation

struct ExpenseModel: Identifiable {
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expenses: [ExpenseModel] = [
    ExpenseModel(amountSpent: "$128", product: "Amazon", productIcon: "amazon", spendType: "Groceries"),
    ExpenseModel(amountSpent: "$18", product: "Youtube", productIcon: "youtube", spendType: "Streaming"),
    ExpenseModel(amountSpent: "$10", product: "Dribble", productIcon: "dribble", spendType: "Membership"),
    ExpenseModel(amountSpent: "$28", product: "Apple", productIcon: "apple", spendType: "Apple Pay"),
    ExpenseModel(amountSpent: "$9", product: "Patreon", productIcon: "patreon", spendType: "Membership"),
    ExpenseModel(amountSpent: "$100", product: "Instagram", productIcon: "instagram", spendType: "Ad Publish"),
    ExpenseModel(amountSpent: "$55", product: "Netflix", productIcon: "netflix", spendType: "Movies"),
    ExpenseModel(amountSpent: "$348", product: "Photoshop", productIcon: "photoshop", spendType: "Editing"),
    ExpenseModel(amountSpent: "$99", product: "Figma", productIcon: "figma", spendType: "Pro Membership")
]
