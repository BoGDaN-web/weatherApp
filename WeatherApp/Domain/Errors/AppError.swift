import Foundation

enum AppError: LocalizedError {
    case invalidURL
    case invalidResponse
    case persistenceError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .persistenceError:
            return "Persistence operation failed."
        }
    }
}
