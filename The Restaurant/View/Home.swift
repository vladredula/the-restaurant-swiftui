//
//  HomeView.swift
//  The Restaurant
//
//  Created by Vlad Redula on 2023/04/19.
//

import SwiftUI

struct Home: View {
    @Binding var moveTo: Int
    
    var body: some View {
        ZStack {
            
            Text("menu")
                .font(.system(size: 100))
                .fontWeight(.heavy)
                .textCase(.uppercase)
                .foregroundColor(Color.gray.opacity(0.1))
                .frame(maxHeight: getRect().height, alignment: .topLeading)
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    Text("menu")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.vertical)

                    ZStack {
                        
                        Text("food")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 60)
                            .padding(.leading, 40)
                            .background(Color("AccentColor"))
                        
                        Image("burger-nobg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: Color.black.opacity(0.7), radius: 20, x: 0, y: 10)
                            .frame(width: 350, height: 180, alignment: .trailing)
                    }
                    .padding(.leading)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            moveTo = 2
                        }
                    }

                    ZStack {
                        
                        Text("drink")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.vertical, 60)
                            .padding(.trailing, 40)
                            .background(Color("AccentColor"))
                        
                        Image("drink-nobg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: Color.black.opacity(0.7), radius: 20, x: 0, y: 10)
                            .frame(width: 350, height: 220, alignment: .leading)
                    }
                    .padding(.trailing)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            moveTo = 3
                        }
                    }
                }
            })
        }
        .background(Color("Background").ignoresSafeArea())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(moveTo: .constant(1))
    }
}

extension View {
    func getRect()->CGRect {
        UIScreen.main.bounds
    }
}
