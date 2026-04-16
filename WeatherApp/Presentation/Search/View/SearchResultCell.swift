import UIKit

final class SearchResultCell: UITableViewCell {
    static let reuseIdentifier = "SearchResultCell"

    func configure(with city: City) {
        var content = defaultContentConfiguration()
        content.text = city.name
        content.secondaryText = city.country
        contentConfiguration = content
        accessoryType = .disclosureIndicator
    }
}
