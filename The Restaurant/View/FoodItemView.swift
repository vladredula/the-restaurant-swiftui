//
//  ItemView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    
    @State var data: Data?
    
    var body: some View {
        
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130)
                .background(Color.gray)
        }
        else {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        
        task.resume()
    }
}

struct FoodItemView: View {
    var currentLang: String = Locale.current.language.languageCode?.identifier ?? ""
    var food: Item
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            URLImage(urlString: food.imgUrl)
            
            VStack {
                
                Text(currentLang == "en" ? food.name : food.tname)
                    .frame(alignment: .leading)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Spacer()
                
                FoodPrices(priceString: food.price)
                    .padding(.trailing)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
                
        }
        .frame(height: 110)
        .background(Color(UIColor.systemGray6))
        .clipShape(Rectangle())
        .padding(.bottom, 10)
    }
}

struct FoodPrices: View {
    
    let priceString: String
    
    @State var priceList: [String:String] = [:]
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            
            ForEach(priceList.sorted(by: <), id: \.key) { key, value in
                
                HStack {
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
        .task {
            priceList = await getPrices()
        }
    }
    
    private func getPrices() async -> [String:String] {
        var newPriceList: [String:String] = [:]
        
        for prices in priceString.components(separatedBy: ",") {
            let price = prices.components(separatedBy: ":")
            
            newPriceList[price[0]] = price[1]
        }
        
        return newPriceList
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        Food()
//            .environment(\.locale, .init(identifier: "ja"))
    }
}
