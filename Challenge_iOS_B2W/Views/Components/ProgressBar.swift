//
//  ProgressBar.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 25/07/21.
//

import SwiftUI

struct ProgressBar: View {
    @EnvironmentObject var detailsViewModel: DetailsViewModel
    
    var value: Float
    
    
    var body: some View {
        let colorPKM = detailsViewModel.getColor()
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(colorPKM.opacity(0.4))
                
                Rectangle().frame(width: min((CGFloat(self.value) * geometry.size.width) / 255, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(colorPKM)
            }.cornerRadius(45.0)
        }
    }
}
