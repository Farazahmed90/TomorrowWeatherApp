//
//  SplashScreen.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 12/01/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            WeatherView(weatherService: OpenMeteoWeatherService())
        } else {
            VStack {
                VStack {
                    Image(systemName: "cloud.sun.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    Text("Tomorrow Weather")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
