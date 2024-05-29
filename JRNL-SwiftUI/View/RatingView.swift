//
//  RatingView.swift
//  JRNL-SwiftUI
//
//  Created by SeongKook on 5/29/24.
//

import Foundation
import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star" )
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        rating = index + 1
                    }
            }

        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
