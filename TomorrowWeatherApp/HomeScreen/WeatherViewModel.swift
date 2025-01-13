//
//  WeatherScreenViewModel.swift
//  TomorrowWeatherApp
//
//  Created by m1 on 11/01/2025.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    
    @Published var weather: WeatherModel?
    @Published var currentCoordinate: (latitude: Double, longitude: Double)?
    @Published var errorMessage: String?

    private let coordinates = [
        (53.619653, 10.079969),
        (53.080917, 8.847533),
        (52.378385, 9.794862),
        (52.496385, 13.444041),
        (53.866865, 10.739542),
        (54.304540, 10.152741),
        (54.797277, 9.491039),
        (52.426412, 10.821392),
        (53.542788, 8.613462),
        (53.141598, 8.242565)
    ]

    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    private var currentIndex = 0
    private let weatherService: WeatherServiceProtocol

    private var lastUpdateTime: Date?

    init(weatherService: WeatherServiceProtocol) {
        
        self.weatherService = weatherService

        if isFreshLaunch() {
            resetState() // Start fresh
        } else {
            restoreState() // Resume from saved state
        }

        startLocationUpdates()
    }

    func startLocationUpdates() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.updateLocation()
        }
        updateLocation()
    }

    private func updateLocation() {
        // Use the currentIndex directly without prematurely updating
        currentCoordinate = coordinates[currentIndex]
        lastUpdateTime = Date()

        // Fetch weather for the current coordinate
        fetchWeather(latitude: coordinates[currentIndex].0, longitude: coordinates[currentIndex].1)

        // Prepare for the next coordinate (timer-driven)
        currentIndex = (currentIndex + 1) % coordinates.count
    }

    private func stopLocationUpdates() {
        timer?.invalidate()
        timer = nil
    }

    func handleAppBackgrounded() {
        // Save the current state to UserDefaults
        UserDefaults.standard.set(currentIndex, forKey: "currentIndex")
        UserDefaults.standard.set(lastUpdateTime, forKey: "lastUpdateTime")
    }

    func handleAppForegrounded() {
        // Restore the state and check elapsed time
        if let lastUpdateTime = UserDefaults.standard.object(forKey: "lastUpdateTime") as? Date {
            let elapsedTime = Date().timeIntervalSince(lastUpdateTime)

            // If less than 10 seconds have passed, stay at the currentIndex
            if elapsedTime < 10.0 {
                return
            }

            // If more than 10 seconds have passed, calculate skipped intervals
            let skippedIntervals = Int(elapsedTime / 10.0)
            currentIndex = (currentIndex + skippedIntervals) % coordinates.count
        }

        // Restart location updates
        startLocationUpdates()
    }

    private func resetState() {
        // Clear saved state and start from the first location
        currentIndex = 0
        currentCoordinate = coordinates[currentIndex]
        lastUpdateTime = Date()
        UserDefaults.standard.removeObject(forKey: "currentIndex")
        UserDefaults.standard.removeObject(forKey: "lastUpdateTime")
    }

    private func restoreState() {
        // Restore the last saved index
        if let savedIndex = UserDefaults.standard.value(forKey: "currentIndex") as? Int {
            currentIndex = savedIndex
        }

        // Restore the last update time
        if let savedLastUpdateTime = UserDefaults.standard.object(forKey: "lastUpdateTime") as? Date {
            lastUpdateTime = savedLastUpdateTime
        }
    }

    private func isFreshLaunch() -> Bool {
        // Determine if this is a fresh launch by checking if there's any saved state
        return UserDefaults.standard.object(forKey: "lastUpdateTime") == nil
    }

    func fetchWeather(latitude: Double, longitude: Double) {
        weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "Error fetching weather: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] weather in
                self?.weather = weather
                self?.errorMessage = nil
            })
            .store(in: &cancellables)
    }
}
