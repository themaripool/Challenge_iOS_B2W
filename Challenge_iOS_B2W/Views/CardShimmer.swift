//
//  CardShimmer.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 20/07/21.
//

import SwiftUI

struct CardShimmer : View {
    
    @State var show = false
    
    var body : some View{
        GeometryReader { geometry in
            ZStack {
                Color.gray.opacity(0.3)
                    .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                    .cornerRadius(6)
                    .overlay(
                        Color.gray
                            .frame(minWidth: geometry.size.width, maxHeight: .infinity)
                            .cornerRadius(6)
                            .mask(
                                Rectangle()
                                    .fill(
                                    
                                        LinearGradient(
                                            gradient: .init(
                                                colors: [.clear, Color.gray.opacity(0.3), .clear]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .rotationEffect(.init(degrees: 120))
                                    .offset(x: self.show ? (UIScreen.main.bounds.width + 100) : -(UIScreen.main.bounds.width + 100))
                                    .frame(
                                        minWidth: UIScreen.main.bounds.width + 100,
                                        maxHeight: .infinity
                                    )
                            )
                    )
            }
            .onAppear {
                withAnimation(Animation.default.speed(0.2).delay(0).repeatForever(autoreverses: false)){
                    self.show = true
                }
            }
        }
    }
}

struct CardShimmer_Previews: PreviewProvider {
    static var previews: some View {
        CardShimmer()
    }
}
