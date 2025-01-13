//
//  test.swift
//  TomorrowWeatherAppTests
//
//  Created by m1 on 12/01/2025.
//

import XCTest
import Combine
@testable import TomorrowWeatherApp

final class WeatherServiceTests: XCTestCase {
    
    private var mockURLSession: MockURLSession!
    private var sut: OpenMeteoWeatherService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = OpenMeteoWeatherService(session: mockURLSession)
        cancellables = []
    }
    
    override func tearDown() {
        mockURLSession = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchWeatherSuccess() {
        
        // Given
        let expectation = XCTestExpectation(description: "Fetch weather data")
        let mockWeatherData = getMockWeatherData()
        let mockResponse = HTTPURLResponse(url: URL(string: "https://api.open-meteo.com/v1/forecast")!,
                                        statusCode: 200,
                                        httpVersion: nil,
                                        headerFields: nil)!
        
        mockURLSession.data = mockWeatherData
        mockURLSession.response = mockResponse
        
        var receivedWeather: WeatherModel?
        var receivedError: Error?
        
        // When
        sut.fetchWeather(latitude: 52.52, longitude: 13.41)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    receivedError = error
                    print("Error: \(error)")
                case .finished:
                    print("Completed successfully")
                }
                expectation.fulfill()
            }, receiveValue: { weather in
                receivedWeather = weather
                print("Received weather: \(weather)")
            })
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(receivedError, "Error should be nil")
        XCTAssertNotNil(receivedWeather, "Weather data should not be nil")
        
        if let weather = receivedWeather {
            XCTAssertEqual(weather.latitude ?? 0, 52.52, accuracy: 0.001)
            XCTAssertEqual(weather.longitude ?? 0, 13.41, accuracy: 0.001)
        } else {
            XCTFail("Weather data should not be nil")
        }
    }
    
    func testFetchWeatherFailure() {
            // Given
            let expectation = XCTestExpectation(description: "Fetch weather data failure")
            let mockError = URLError(.notConnectedToInternet)
            mockURLSession.error = mockError
            
            var receivedWeather: WeatherModel?
            var receivedError: Error?
            
            // When
            sut.fetchWeather(latitude: 52.52, longitude: 13.41)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        receivedError = error
                        print("Received expected error: \(error)")
                    case .finished:
                        print("Completed successfully")
                    }
                    expectation.fulfill()
                }, receiveValue: { weather in
                    receivedWeather = weather
                    print("Received weather: \(weather)")
                })
                .store(in: &cancellables)
            
            // Then
            wait(for: [expectation], timeout: 1.0)
            XCTAssertNotNil(receivedError, "Error should not be nil")
            XCTAssertNil(receivedWeather, "Weather data should be nil")
            XCTAssertTrue(receivedError is URLError, "Error should be URLError")
            
            if let urlError = receivedError as? URLError {
                XCTAssertEqual(urlError.code, URLError.notConnectedToInternet)
            } else {
                XCTFail("Error should be URLError")
            }
        }
    
    // MARK: - Helpers
    
    private func getMockWeatherData() -> Data {
     
        let jsonString = """
        {
            "latitude": 52.52,
            "longitude": 13.41,
            "generationtime_ms": 0.2510547637939453,
            "utc_offset_seconds": 0,
            "timezone": "GMT",
            "timezone_abbreviation": "GMT",
            "elevation": 38,
            "current_units": {
                "time": "iso8601",
                "interval": "seconds",
                "temperature_2m": "°C",
                "wind_speed_10m": "km/h",
                "relative_humidity_2m": "%"
            },
            "current": {
                "time": "2024-01-12T12:00",
                "interval": 900,
                "temperature_2m": 20.5,
                "wind_speed_10m": 15.3,
                "relative_humidity_2m": 65
            },
            "hourly_units": {
                "time": "iso8601",
                "temperature_2m": "°C",
                "relative_humidity_2m": "%",
                "wind_speed_10m": "km/h"
            },
            "hourly": {
                "time": ["2024-01-12T12:00"],
                "temperature_2m": [20.5],
                "relative_humidity_2m": [65],
                "wind_speed_10m": [15.3]
            }
        }
        """
        
        // Verify that the data can be decoded
        let data = jsonString.data(using: .utf8)!
        do {
            let decoder = JSONDecoder()
            let _ = try decoder.decode(WeatherModel.self, from: data)
            print("Mock data successfully decoded")
        } catch {
            print("Mock data decoding failed: \(error)")
        }
        
        return data
    }
}
