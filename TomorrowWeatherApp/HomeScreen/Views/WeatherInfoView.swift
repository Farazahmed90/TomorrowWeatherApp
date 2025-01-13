//
//  WeatherInfoView.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 12/01/2025.
//

import SwiftUI

struct WeatherInfoView: View {
    
    var weather: WeatherModel?
    
    var body: some View {
        VStack(spacing: 15) {
            if let weather = self.weather {
                HStack(spacing: 15) {
                    InfoCard(
                        title: "Humidity",
                        value: "\(weather.current?.relativeHumidity2m ?? 0) \(weather.currentUnits?.relativeHumidity2M ?? "")", iconName: "humidity.fill")
                    InfoCard(title: "Elevation", value: "\(weather.elevation ?? 0)m", iconName: "mountain.2")
                }
                InfoCard(title: "Wind", value: "\(String(format: "%.1f", weather.current?.windSpeed10M ?? 0)) \(weather.currentUnits?.windSpeed10M ?? "")", iconName: "wind.circle.fill")
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .background(Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all))
        .cornerRadius(12)
    }
}

#Preview {
    WeatherInfoView()
}
