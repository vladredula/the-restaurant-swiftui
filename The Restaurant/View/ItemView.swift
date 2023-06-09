//
//  ItemView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct FoodItemView: View {
    var currentLang: String = Locale.current.language.languageCode?.identifier ?? ""
    var food: Item
    
    var body: some View {
        
        HStack {
            
            AsyncImage(url: URL(string: food.imgUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
//                ProgressView()
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
            .frame(width: 130, height: 110)
            .background(Color.gray.opacity(0.3))
            
            VStack {
                
                Text(currentLang == "en" ? food.name : food.tname)
                    .frame(alignment: .leading)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Spacer()
                
                VStack {
                    ItemPrices(priceString: food.price)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.trailing)
                .padding(.bottom)
            }
                
        }
        .frame(height: 110)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2.5)
        .padding(.horizontal)
    }
}

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
            
            HStack {
                ItemPrices(priceString: drink.price)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            .padding(.top, 1)
            .padding(.bottom)
        }
        .background(Color("Background"))
    }
}

struct ItemPrices: View {
    
    let priceString: String

    private var getPrices: [String:String] {
        var newPriceList: [String:String] = [:]
        
        for prices in priceString.components(separatedBy: ",") {
            let price = prices.components(separatedBy: ":")
            
            newPriceList[price[0]] = price[1]
        }
        
        return newPriceList
    }
    
    var body: some View {
        
        ForEach(getPrices.sorted(by: <), id: \.key) { key, value in
                
            HStack (spacing: 5) {
                if key != "1" {
                    Text(LocalizedStringKey(key))
                        .fontWeight(.semibold)
                }
                
                (
                    Text("¥")
                        .font(.footnote)
                        .foregroundColor(Color.accentColor)
                    +
                    Text(value)
                )
                .fontWeight(.bold)
                
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        Food()
//            .environment(\.locale, .init(identifier: "ja"))
    }
}
