import Foundation

protocol CitySearchServiceProtocol {
    func searchCities(query: String) async throws -> [City]
}
