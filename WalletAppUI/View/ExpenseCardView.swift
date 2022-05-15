//
//  ExpenseCardView.swift
//  WalletAppUI
//
//  Created by Kanishk Vijaywargiya on 15/05/22.
//

import Foundation
import SwiftUI

struct ExpenseCardView: View {
    var expense: ExpenseModel
    
    // displaying expenses one by one based on their indexes
    @State var showView: Bool = false
    
    var body: some View {
        HStack(spacing: 14) {
            productIcon
            productAndSpendType
            amountSpent
        }
        .opacity(showView ? 1 : 0) // for pushing from bottom effect
        .onAppear {
            // time taken to show up
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3).delay(Double(getIndex()) * 0.1)) {
                    showView = true
                }
            }
        }
    }
    
    func getIndex() -> Int {
        return expenses.firstIndex { currentExpense in
            return expense.id == currentExpense.id
        } ?? 0
    }
}

extension ExpenseCardView {
    private var productIcon: some View {
        Image(expense.productIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 45, height: 45)
    }
    private var productAndSpendType: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(expense.product).fontWeight(.bold).foregroundColor(.primary)
            Text(expense.spendType).font(.caption).foregroundColor(.gray)
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var amountSpent: some View {
        VStack(spacing: 8) {
            Text(expense.amountSpent).fontWeight(.bold).foregroundColor(.primary)
            Text(Date().formatted(date: .numeric, time: .omitted)).font(.caption).foregroundColor(.gray)
        }
    }
}
