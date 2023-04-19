//
//  BusinessSection.swift
//  CitySights
//
//  Created by Leonardo Caracho on 13/04/23.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businesses: [Business]
    
    var body: some View {
        Section(header: BusinessSectionHeader(title: title).bold()) {
            ForEach(businesses) { business in
                NavigationLink(destination: BusinessDetail(business: business)) {
                    BusinessRow(business: business)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct BusinessSection_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSection(title: "", businesses: [])
    }
}
