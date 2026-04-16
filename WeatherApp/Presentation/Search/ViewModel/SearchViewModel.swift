import Foundation

final class SearchViewModel {
    enum State {
        case idle
        case loading
        case loaded([City])
        case failed(String)
    }

    private let service: CitySearchServiceProtocol
    var onStateChange: ((State) -> Void)?

    init(service: CitySearchServiceProtocol = CitySearchService()) {
        self.service = service
    }

    func search(query: String) async {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmed.isEmpty == false else {
            await MainActor.run {
                self.onStateChange?(.idle)
            }
            return
        }

        await MainActor.run {
            self.onStateChange?(.loading)
        }

        do {
            let cities = try await service.searchCities(query: trimmed)
            await MainActor.run {
                self.onStateChange?(.loaded(cities))
            }
        } catch {
            await MainActor.run {
                self.onStateChange?(.failed(error.localizedDescription))
            }
        }
    }
}
