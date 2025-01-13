//
//  WeatherModel.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 11/01/2025.
//

import Foundation

struct WeatherModel: Codable {
    
    let latitude: Double?
    let longitude: Double?
    let generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone: String?
    let timezoneAbbreviation: String?
    let elevation: Int?
    let currentUnits: Units?
    let current: CurrentWeather?
    let hourlyUnits: Units?
    let hourly: HourlyData?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    
    let time: String?
    let interval: Int?
    let relativeHumidity2m: Int?
    let temperature2M: Double?
    let windSpeed10M: Double?
    
    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
        case relativeHumidity2m = "relative_humidity_2m"
    }
}

// MARK: - Units
struct Units: Codable {
    
    let time: String?
    let interval: String?
    let temperature2M: String?
    let windSpeed10M: String?
    let relativeHumidity2M: String?
    
    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
        case relativeHumidity2M = "relative_humidity_2m"
    }
}

// MARK: - HourlyData
struct HourlyData: Codable {
    
    let time: [String]?
    let temperature2M: [Double]?
    let relativeHumidity2M: [Int]?
    let windSpeed10M: [Double]?
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
    }
}
