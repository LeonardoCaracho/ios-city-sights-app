//
//  BusinessTitle.swift
//  CitySights
//
//  Created by Leonardo Caracho on 23/04/23.
//

import SwiftUI

struct BusinessTitle: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(business.name!)
                .font(.title2)
                .bold()
            
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            Image("regular_\(business.rating ?? 0)")
        }
    }
}

