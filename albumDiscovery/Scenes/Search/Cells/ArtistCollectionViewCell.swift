import UIKit
import AlamofireImage

class ArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    func setupCell(with title: String, andSubtitle subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

