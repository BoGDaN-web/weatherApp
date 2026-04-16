import Foundation

final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let defaults: UserDefaults
    private let storageKey = "favorite_cities"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func fetchFavorites() throws -> [City] {
        guard let data = defaults.data(forKey: storageKey) else {
            return []
        }

        do {
            return try decoder.decode([City].self, from: data)
        } catch {
            throw AppError.persistenceError
        }
    }

    func save(city: City) throws {
        var cities = try fetchFavorites()
        guard cities.contains(city) == false else { return }
        cities.append(city)
        try persist(cities)
    }

    func remove(city: City) throws {
        let updated = try fetchFavorites().filter { $0 != city }
        try persist(updated)
    }

    func isFavorite(city: City) throws -> Bool {
        try fetchFavorites().contains(city)
    }

    private func persist(_ cities: [City]) throws {
        do {
            let data = try encoder.encode(cities)
            defaults.set(data, forKey: storageKey)
        } catch {
            throw AppError.persistenceError
        }
    }
}
