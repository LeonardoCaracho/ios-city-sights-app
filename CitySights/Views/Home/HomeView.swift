//
//  HomeView.swift
//  CitySights
//
//  Created by Leonardo Caracho on 12/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if !model.restaurants.isEmpty || !model.sights.isEmpty {
            
            NavigationView {
                if !isMapShowing {
                    VStack {
                        HStack (alignment: .firstTextBaseline) {
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Button("Switch to map view") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        BusinessList()
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                } else {
                    BusinessMap()
                        .ignoresSafeArea()
                }
            }
        } else {
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
