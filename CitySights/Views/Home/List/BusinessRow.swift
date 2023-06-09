//
//  BusinessRow.swift
//  CitySights
//
//  Created by Leonardo Caracho on 13/04/23.
//

import SwiftUI

struct BusinessRow: View {
    @ObservedObject var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                
                VStack(alignment: .leading)  {
                    Text(business.name ?? "")
                    Text(String(format: "%.1f km away", (business.distance ?? 0)/1000))
                        .font(.caption)
                }
                
                Spacer()
                
                VStack(alignment: .leading)  {
                    Image("regular_\(business.rating ?? 0.0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            
            DashedDivider()
                .padding(.vertical)
        }
    }
}

