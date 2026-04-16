import Foundation

final class WeatherRepository: WeatherRepositoryProtocol {
    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: City) async throws -> WeatherData {
        let response = try await weatherService.fetchWeather(latitude: city.latitude, longitude: city.longitude)
        return WeatherMapper.map(response: response, city: city)
    }
}
