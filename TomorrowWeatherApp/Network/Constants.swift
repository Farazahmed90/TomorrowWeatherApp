//
//  API.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 12/01/2025.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api.open-meteo.com/v1"
}

enum APIEndpoint {
    
    case forecast(latitude: Double, longitude: Double)

    var url: URL? {
        switch self {
        case .forecast(let latitude, let longitude):
            var components = URLComponents(string: "\(APIConstants.baseURL)/forecast")
            components?.queryItems = [
                URLQueryItem(name: "latitude", value: "\(latitude)"),
                URLQueryItem(name: "longitude", value: "\(longitude)"),
                URLQueryItem(name: "current", value: "temperature_2m,wind_speed_10m,relative_humidity_2m"),
                URLQueryItem(name: "hourly", value: "temperature_2m,relative_humidity_2m,wind_speed_10m")
            ]
            return components?.url
        }
    }
}
