//
//  WeatherService.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 11/01/2025.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error>
}

class OpenMeteoWeatherService: WeatherServiceProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error> {

        guard let url = APIEndpoint.forecast(latitude: latitude, longitude: longitude).url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.fetchDataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
