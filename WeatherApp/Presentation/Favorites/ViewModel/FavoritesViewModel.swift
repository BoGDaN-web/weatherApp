import Foundation

final class FavoritesViewModel {
    enum State {
        case loaded([City])
        case failed(String)
    }

    private let repository: FavoritesRepositoryProtocol
    var onStateChange: ((State) -> Void)?

    init(repository: FavoritesRepositoryProtocol = FavoritesRepository()) {
        self.repository = repository
    }

    func loadFavorites() {
        do {
            onStateChange?(.loaded(try repository.fetchFavorites()))
        } catch {
            onStateChange?(.failed(error.localizedDescription))
        }
    }

    func remove(city: City) {
        do {
            try repository.remove(city: city)
            loadFavorites()
        } catch {
            onStateChange?(.failed(error.localizedDescription))
        }
    }
}
