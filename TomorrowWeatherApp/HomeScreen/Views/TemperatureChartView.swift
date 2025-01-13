//
//  WeatherDetailView.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 11/01/2025.
//

import SwiftUI
import Charts

struct TemperatureChartView: View {
    
    let hourlyTemperatures: [Double]
    let hourlyTimes: [String]
    
    var body: some View {
        Chart {
            ForEach(0..<hourlyTemperatures.count, id: \.self) { index in
                LineMark(
                    x: .value("Time", hourlyTimes[index]),
                    y: .value("Temperature", hourlyTemperatures[index])
                )
            }
        }
        .frame(height: 200)
    }
}

