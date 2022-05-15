//
//  DetailView.swift
//  WalletAppUI
//
//  Created by Kanishk Vijaywargiya on 15/05/22.
//

import SwiftUI

struct DetailView: View {
    var currentCard: Card
    @StateObject private var vm = CardViewModel()
    @Binding var showDetailCard: Bool
    var animation: Namespace.ID // MARK: Matched Geometry Effect
    @State var showExpensesView: Bool  = false // Delaying expenses view
    
    
    var body: some View {
        VStack {
            CardView()
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .frame(height: 200)
                .onTapGesture {
                    // closing expenses view first
                    withAnimation(.easeInOut) {
                        showExpensesView = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            showDetailCard = false
                        }
                    }
                }
                .zIndex(10)
            
            ExpenseCards
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("BG").ignoresSafeArea())
        .onAppear {
            withAnimation(.easeInOut.delay(0.1)) {
                showExpensesView = true
            }
        }
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack(alignment: .bottomLeading) {
            Image(currentCard.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // Card details
            VStack(alignment: .leading, spacing: 10) {
                Text(currentCard.name)
                    .fontWeight(.bold)
                Text(vm.customisedCardNumber(number: currentCard.cardNumber))
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .padding()
            .padding(.bottom, 10)
            .foregroundColor(.white)
        }
        .cornerRadius(20)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

extension DetailView {
    private var ExpenseCards: some View {
        GeometryReader { geo in
            let height = geo.size.height + 50
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // expenses
                    ForEach(expenses) { expense in
                        // Card View
                        ExpenseCardView(expense: expense)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(
                Color("background")
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .ignoresSafeArea()
            )
            .offset(y: showExpensesView ? 0: height)
        }
        .padding([.horizontal, .top])
        .zIndex(-10)
    }
}
