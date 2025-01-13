//
//  WeatherScreenView.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 11/01/2025.
//

import SwiftUI
import Charts

struct WeatherView: View {
    
    @StateObject private var viewModel: WeatherViewModel
    @Environment(\.scenePhase) var scenePhase
    
    init(weatherService: WeatherServiceProtocol) {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(weatherService: weatherService))
    }
    
    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                VStack(spacing: 16) {
                    
                    // Current Weather
                    locationAndTempView(weather: weather)
                    
                    ScrollView {
                        // WeatherInfoView
                        WeatherInfoView(weather: weather)
                        
                        //Graph
                        chartView()
                    }
                    .padding()
                    .scrollIndicators(.hidden)
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                viewModel.handleAppBackgrounded()
            } else if scenePhase == .active {
                viewModel.handleAppForegrounded()
            }
        }
        .onAppear {
            viewModel.startLocationUpdates()
        }
    }
    
    private func locationAndTempView(weather: WeatherModel) -> some View {
        VStack(spacing: 4) {
            Text("📍 You're Here!")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("Latitude: \(String(format: "%.4f", weather.latitude ?? 0))\nLongitude: \(String(format: "%.4f", weather.longitude ?? 0))")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.9))
                .lineSpacing(5)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                )
                .fixedSize(horizontal: false, vertical: true)
            
            Text("\(String(format: "%.0f", weather.current?.temperature2M ?? 0)) \(weather.currentUnits?.temperature2M ?? "")")
                .font(.system(size: 64, weight: .bold))
            
        }
        .padding(.top, 12)
    }
    
    private func chartView() -> some View {
        VStack(spacing: 16) {
            Text("Temperature chart between time and tempearature: ")
                .font(.system(size: 16, weight: .semibold))
            
            if let weather = viewModel.weather {
                TemperatureChartView(hourlyTemperatures: weather.hourly?.temperature2M ?? [], hourlyTimes: weather.hourly?.time ?? [])
            } else {
                Text("No details available.")
                    .font(.headline)
                    .padding()
            }
        }
        .frame(alignment: .center)
    }
}

#Preview {
    WeatherView(weatherService: OpenMeteoWeatherService())
}
