//
//  URLSession.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 12/01/2025.
//

import Foundation
import Combine

protocol URLSessionProtocol {
    func fetchDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionProtocol {
    func fetchDataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        self.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}
