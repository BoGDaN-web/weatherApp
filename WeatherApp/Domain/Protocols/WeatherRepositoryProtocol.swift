import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeather(for city: City) async throws -> WeatherData
}
