//
//  BusinessDetail.swift
//  CitySights
//
//  Created by Leonardo Caracho on 17/04/23.
//

import SwiftUI

struct BusinessDetail: View {
    var business: Business
    @State private var showDirections = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader() { geometry in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            
            Group {
                HStack {
                    BusinessTitle(business: business)
                        .padding()
                    Spacer()
                    YelpAttribution(link: business.url!)
                }
            }
            
            DashedDivider()
                .padding(.horizontal)
            
            HStack {
                Text("Phone")
                    .bold()
                Text(business.displayPhone!)
                
                Spacer()
                
                Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
            }
            .padding()
            
            DashedDivider()
                .padding(.horizontal)
            
            HStack {
                Text("Reviews")
                    .bold()
                Text(String(business.reviewCount ?? 0))
                
                Spacer()
                
                Link("Read", destination: URL(string: "\(business.url ?? "")")!)
            }
            .padding()
            
            DashedDivider()
                .padding(.horizontal)
            
            HStack {
                Text("Website")
                    .bold()
                Text(String(business.url ?? ""))
                    .lineLimit(1)
                
                Spacer()
                
                Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
            }
            .padding()
            
            DashedDivider()
                .padding(.horizontal)
            
            Button(
                action: {
                    showDirections = true
                }
            ) {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding()
            .sheet(isPresented: $showDirections, content: {
                DirectionsView(business: business)
            })
        }
    }
}
