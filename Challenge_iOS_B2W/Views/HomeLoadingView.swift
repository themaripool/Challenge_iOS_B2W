//
//  HomeLoadingView.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 20/07/21.
//

import SwiftUI

struct HomeLoadingView: View {
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                ForEach(0..<5) { _ in
                    CardShimmer()
                        .frame(height: 130)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                }
            }
        }
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

struct HomeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        HomeLoadingView()
    }
}

