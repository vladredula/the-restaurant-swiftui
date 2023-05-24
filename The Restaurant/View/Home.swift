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
                
                VStack(spacing: 10) {
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
                            .cornerRadius(25, corners: [.topLeft, .bottomLeft])
                        
                        Image("burger-nobg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 180, alignment: .trailing)
                    }
                    .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                    .padding(.leading, 20)
                    .padding(.bottom)
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
                            .cornerRadius(25, corners: [.topRight, .bottomRight])
                        
                        Image("drink-nobg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 210, alignment: .leading)
                    }
                    .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                    .padding(.trailing, 20)
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

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func getRect()->CGRect {
        UIScreen.main.bounds
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
