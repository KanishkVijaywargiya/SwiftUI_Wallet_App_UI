//
//  Home.swift
//  WalletAppUI
//
//  Created by Kanishk Vijaywargiya on 15/05/22.
//

import SwiftUI

struct Home: View {
    @State private var expandCards: Bool = false // animation properties
    @StateObject var vm = CardViewModel()
    
    // MARK: details view properties
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0) {
            title
            cardsView
            addButton // MARK: Add button
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if let currentCard = currentCard, showDetailCard {
                DetailView(currentCard: currentCard, showDetailCard: $showDetailCard, animation: animation)
            }
        }
    }
    
    // MARK: Card view
    @ViewBuilder
    func CardView(card: Card) -> some View {
        GeometryReader { geo in
            let rect = geo.frame(in: .named("SCROLL"))
            
            // let's display some portion of each card
            let offset = CGFloat(vm.getIndex(Card: card) * (expandCards ? 10 : 70))
            
            ZStack(alignment: .bottomLeading) {
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // Card details
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name)
                        .fontWeight(.bold)
                    Text(vm.customisedCardNumber(number: card.cardNumber))
                        .font(.callout)
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.bottom, 10)
                .foregroundColor(.white)
            }
            .cornerRadius(20)
            .offset(y: expandCards ? offset : -rect.minY + offset) // making it as a stack
        }
        .frame(height: 200)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


extension Home {
    private var title: some View {
        Text("Wallet")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)
            .overlay (alignment: .trailing) {
                // MARK: Close button
                closeButton
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
    }
    private var closeButton: some View {
        Button(action: {
            //closing card
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                expandCards = false
            }
        }, label: {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding(10)
                .background(.blue, in: Circle())
        })
        .rotationEffect(.init(degrees: expandCards ? 45 : 0))
        .offset(x: expandCards ? 10 : 15)
        .opacity(expandCards ? 1 : 0)
    }
    private var cardsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                // MARK: Cards
                ForEach(cards) { card in
                    // if you want pure transition without this little opacity change in the sense just remove this if...else condition
                    Group {
                        CardView(card: card)
                            .matchedGeometryEffect(id: card.id, in: animation)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            currentCard = card
                            showDetailCard = true
                        }
                    }
                }
            }
            .overlay(rectangle) // to avoid scrolling
            .padding(.top, expandCards ? 30 : 0)
        }
        .coordinateSpace(name: "SCROLL")
        .offset(y: expandCards ? 0 : 30)
    }
    private var rectangle: some View {
        Rectangle()
            .fill(.black.opacity(expandCards ? 0 : 0.01))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.35)) {
                    expandCards = true
                }
            }
    }
    private var addButton: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .padding(20)
                .background(.blue, in: Circle())
        }
        .rotationEffect(.init(degrees: expandCards ? 180 : 0))
        .scaleEffect(expandCards ? 0.01 : 1) // to avoid warnings 0.01
        .opacity(!expandCards ? 1 : 0)
        .frame(height: expandCards ? 0 : nil)
        .padding(.bottom, expandCards ? 0 : 30)
    }
    private var stackOfCards: some View {
        Text("hello")
    }
}
