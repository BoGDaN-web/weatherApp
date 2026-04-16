import UIKit

final class FavoriteCityCell: UITableViewCell {
    static let reuseIdentifier = "FavoriteCityCell"

    func configure(with city: City) {
        var content = defaultContentConfiguration()
        content.text = city.name
        content.secondaryText = city.country
        contentConfiguration = content
        accessoryType = .disclosureIndicator
    }
}
