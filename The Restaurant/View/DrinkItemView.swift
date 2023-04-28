//
//  DrinkItemView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct DrinkItemView: View {
    var currentLang: String = Locale.current.language.languageCode?.identifier ?? ""
    
    var drink: Item
    
    var body: some View {

        VStack {
            
            Text(currentLang == "en" ? drink.name : drink.tname)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top)
            
            DrinkPrices(priceString: drink.price)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 1)
                .padding(.bottom)
        }
        .background(Color("Background"))
    }
}

struct DrinkPrices: View {
    
    let priceString: String
    
    @State var priceList: [String:String] = ["1":"1"]
    
    var body: some View {
        HStack (spacing: 10) {
            ForEach(priceList.sorted(by: <), id: \.key) { key, value in
                HStack (spacing: 5) {
                    if key != "1" {
                        Text(LocalizedStringKey(key))
                            .fontWeight(.semibold)
                    }
                    
                    if value != "1" {
                        (
                        Text("¥")
                            .foregroundColor(Color.accentColor)
                        +
                        Text(value)
                        )
                        .fontWeight(.bold)
                    }
                }
            }
        }
        .onAppear {
            getPrices()
        }
    }
    
    private func getPrices() {
        var price: [String]
        
        for prices in priceString.components(separatedBy: ",") {
            price = prices.components(separatedBy: ":")
            
            self.priceList[price[0]] = price[1]
        }
    }
}

struct DrinkItemView_Previews: PreviewProvider {
    static var previews: some View {
        Drink()
    }
}
