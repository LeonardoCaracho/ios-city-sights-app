//
//  DeniedView.swift
//  CitySights
//
//  Created by Leonardo Caracho on 12/04/23.
//

import SwiftUI

struct DeniedView: View {
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("Grant location permission to use the App!")
            
            Spacer()
            
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea()
    }
}

struct DeniedView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedView()
    }
}
