//
//  ContentView.swift
//  CitySights
//
//  Created by Leonardo Caracho on 23/03/23.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.authorizationState == .notDetermined {
            OnboardingView()
        } else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            HomeView()
        } else {
            DeniedView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ContentModel())
    }
}
