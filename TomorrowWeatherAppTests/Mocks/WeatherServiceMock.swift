//
//  MockWeatherService.swift
//  TomorrowWeatherAppTests
//
//  Created by m1 on 12/01/2025.
//

import Foundation
import Combine

class MockURLSession: URLSessionProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: URLError?
    
    func fetchDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {

        if let data = data, let response = response {
            return Just((data: data, response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        } else if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: URLError(.unknown))
            .eraseToAnyPublisher()
    }
}
