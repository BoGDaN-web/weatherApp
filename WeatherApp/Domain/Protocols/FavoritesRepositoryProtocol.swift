import Foundation

protocol FavoritesRepositoryProtocol {
    func fetchFavorites() throws -> [City]
    func save(city: City) throws
    func remove(city: City) throws
    func isFavorite(city: City) throws -> Bool
}
